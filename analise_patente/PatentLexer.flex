
%%

%standalone 
%class PatentLexer
%unicode
%line
%column
%state NUMERO, TITULO, DATA, ABSTRACT, CLAIMS

regrasGerais = [ \t\n\r]+
virgula = ","
letras = [A-Za-z]
num = [0-9]
digito = {num}+

npt = {digito}

prn = "<td align=\"RIGHT\" width=\"50%\"><b>"
sfn = "</b></td>"

prt = "<font size=\"+1\">"
sft = "</font>"

prd = "<td align=\"RIGHT\" width=\"50%\"><b>"
sfd = "</b></td>"

prr = "<CENTER><B>Abstract</B></CENTER>\n<P>"
sfr = "</P>"

prc = "<CENTER><B><I>Claims</B></I></CENTER>\n<HR>\n<BR><BR>"
sfc = "<HR>"

%%

<YYINITIAL> {
    {prn}                { yybegin(NUMERO); }
    {prt}                { yybegin(TITULO); }
    {prd}                { yybegin(DATA); }
    {prr}                { yybegin(ABSTRACT); }
    {prc}                { yybegin(CLAIMS); }
    {regrasGerais}       { /* ignora espaços e quebras */ }
    .|\n                 { /* ignora o restante */ }
}

<NUMERO> {
    [^<>\n\r][^<]*        { System.out.println("Número da Patente: " + yytext()); yybegin(YYINITIAL); }
}

<TITULO> {
    [^<>\n\r][^<]*        { System.out.println("Título: " + yytext()); yybegin(YYINITIAL); }
}

<DATA> {
    [^<>\n\r][^<]*    { System.out.println("Data de Publicação: " + yytext()); yybegin(YYINITIAL); }
}

<ABSTRACT> {
    [^<>\n\r][^<]*        { System.out.println("Resumo: " + yytext()); yybegin(YYINITIAL); }
}

<CLAIMS> {
    "What is claimed is:"  { System.out.println("Reivindicações:"); }
    [0-9]+"."[^<]*         { System.out.println(yytext()); }
    {sfc}                  { yybegin(YYINITIAL); }
}
