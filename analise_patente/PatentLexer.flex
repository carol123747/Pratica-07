
%%

%standalone 
%class PatentLexer
%unicode
%line
%column
%state NUMERO, TITULO, DATA, ABSTRACT, CLAIMS

% Definições de expressões regulares
regrasGerais = [ \t\n\r]+          // Regras gerais para caracteres de espaço em branco
virgula = ","                      // Corresponde a uma vírgula
letras = [A-Za-z]                  // letras (maiúsculas e minúsculas)
num = [0-9]                        // numero
digito = {num}+                    // um ou mais numeros

// Tags HTML 
prn = "<td align=\"RIGHT\" width=\"50%\"><b>"  // prefixo numero(number)
sfn = "</b></td>"                              // sufixo numero(number)

prt = "<font size=\"+1\">"                   // prefixo titulo
sft = "</font>"                              // sufixo titulo

prd = "<td align=\"RIGHT\" width=\"50%\"><b>" // prefixo data de publicação
sfd = "</b></td>"                             // sufixo data de publicação

prr = "<CENTER><B>Abstract</B></CENTER>\n<P>" // prefixo resumo(abstract)
sfr = "</P>"                                  // sufixo resumo(abstract)

prc = "<CENTER><B><I>Claims</B></I></CENTER>\n<HR>\n<BR><BR>" // prefixo reivindicações (claims)
sfc = "<HR>"                                                  // sufixo reivindicações (claims)

%%

// tags de abertura do HTML 
<YYINITIAL> {
    {prn}                { yybegin(NUMERO); }                   // Transição para o estado NUMERO 
    {prt}                { yybegin(TITULO); }                   // Transição para o estado TITULO 
    {prd}                { yybegin(DATA); }                     // Transição para o estado DATA 
    {prr}                { yybegin(ABSTRACT); }                 // Transição para o estado ABSTRACT 
    {prc}                { yybegin(CLAIMS); }                   // Transição para o estado CLAIMS 
    {regrasGerais}       { /* Ignora espaços em branco */ }     // Ignora espaços em branco
    .|\n                 { /* Ignora o restante */ }            // Ignora quaisquer outros caracteres
}

// para número da patente
<NUMERO> {
    [^<>\n\r][^<]*        { System.out.println("Número da Patente: " + yytext()); yybegin(YYINITIAL); }
}

// para título
<TITULO> {
    [^<>\n\r][^<]*        { System.out.println("Título: " + yytext()); yybegin(YYINITIAL); }
}

// para data de publicação
<DATA> {
    [^<>\n\r][^<]*        { System.out.println("Data de Publicação: " + yytext()); yybegin(YYINITIAL); }
}

// para resumo
<ABSTRACT> {
    [^<>\n\r][^<]*        { System.out.println("Resumo: " + yytext()); yybegin(YYINITIAL); }
}

// para reivindicações
<CLAIMS> {
    "What is claimed is:"  { System.out.println("Reivindicações:"); }
    [0-9]+"."[^<]*         { System.out.println(yytext()); } // Imprime cada reivindicação
    {sfc}                  { yybegin(YYINITIAL); } // Transição de volta para o estado inicial
}