
%%

%standalone 
%class PatentLexer
%unicode
%line
%column
%state NUMERO, TITULO, DATA, ABSTRACT, CLAIMS // aqui eu coloquei todos os estados ou nome das tags do exercicio

// nessa parte tem as definições 
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
    [^<>\n\r][^<]*        { System.out.println("Número da Patente: " + yytext()); yybegin(YYINITIAL); } //pega o conteudo dentro das tags que representam o numero da patente e imprime
}

// para título
<TITULO> {
    [^<>\n\r][^<]*        { System.out.println("Título: " + yytext()); yybegin(YYINITIAL); } //pega o conteudo dentro das tags de titulo e imprime
}

// para data de publicação
<DATA> {
    [^<>\n\r][^<]*        { System.out.println("Data de Publicação: " + yytext()); yybegin(YYINITIAL); } //pega o conteudo dentro das tags que representam a data da patente e imprime
}

// para resumo
<ABSTRACT> {
    [^<>\n\r][^<]*        { System.out.println("Resumo: " + yytext()); yybegin(YYINITIAL); } //pega o conteudo dentro das tags que representam o abstract da patente e imprime
}

// para reivindicações
<CLAIMS> {
    "Claims:"  { System.out.println("Reivindicações:"); } 
    [0-9]+"."[^<]*         { System.out.println(yytext()); } // Imprime cada reivindicação
    {sfc}                  { yybegin(YYINITIAL); } // Transição de volta para o estado inicial (essa transição tb ocorre nos outros casos)
}
