%{
    #include <stdio.h>
    #include <stdlib.h>

    typedef enum{
        ID,
        NUM_NOTACAO_CIENTIFICA,
        NUM_PONTO_FLUTUANTE,
        NUM_INTEIRO,

        MAIS, MENOS, VEZES, DIVIDE,
        E, OU, NAO,
        DIFERENTE, MENOR_IGUAL, MAIOR_IGUAL,
        MENOR, MAIOR, IGUAL,

        ABRE_PARENTESE, FECHA_PARENTESE,
        ABRE_COLCHETE, FECHA_COLCHETE,
        VIRGULA, DOIS_PONTOS, ATRIBUICAO,

        SE, ENTAO, SENAO, FIM,
        REPITA, FLUTUANTE, RETORNA,
        ATE, LEIA, ESCREVA, INTEIRO

    }TokenType;
    TokenType current_token;

    const char* tokenName[] = {
        "ID",
        "NUM_NOTACAO_CIENTIFICA",
        "NUM_PONTO_FLUTUANTE",
        "NUM_INTEIRO",

        "MAIS", "MENOS", "VEZES", "DIVIDE",
        "E", "OU", "NAO",
        "DIFERENTE", "MENOR_IGUAL", "MAIOR_IGUAL",
        "MENOR", "MAIOR", "IGUAL",

        "ABRE_PARENTESE", "FECHA_PARENTESE",
        "ABRE_COLCHETE", "FECHA_COLCHETE",
        "VIRGULA", "DOIS_PONTOS", "ATRIBUICAO",

        "SE", "ENTAO", "SENAO", "FIM",
        "REPITA", "FLUTUANTE", "RETORNA",
        "ATE", "LEIA", "ESCREVA", "INTEIRO"
    };
%}

DIGITO       [0-9]
LETRA        [a-zA-ZáÁãÃàÀéÉíÍóÓõÕ]
SINAL        [+-]
ID           {LETRA}({LETRA}|{DIGITO}|_)*
INTEIRO      {DIGITO}+
FLUTUANTE    {DIGITO}+\.{DIGITO}*([eE]{SINAL}?{DIGITO}+)?
CIENTIFICA   {SINAL}?[1-9]\.{DIGITO}+[eE]{SINAL}?{DIGITO}+

%%
{INTEIRO}   {return(NUM_INTEIRO); }
{FLUTUANTE} {printf("FLUTUANTE\n"); }
{ID}        {printf("ID\n");}
[[:space:]] ;
[[:^space:]] ;
%% 

int main(){

    FILE *arquivo;
    long tamanhoArquivo;
    char *conteudo;

    arquivo = fopen("tests/teste-001.tpp", "r");
    if(arquivo == NULL){
        printf("Erro ao abrir o arquivo");
        return(1);
    }
    yyin = arquivo;

    int token;
    while ((token = yylex()) != 0) {
        printf("%s", tokenName[token]);
    }
    fclose(arquivo);
    return 0;
}