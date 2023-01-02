#include <stdio.h>
#include <string.h>
#include <stdlib.h>



void whyamihere()
{
	printf("Don't ask me, you came here yourself!\n");
	exit(1);
}

void intialres()
{
	char initals[5];
	printf("Enter your initals: ");
	scanf("%s", initals);
	printf("OK, not sure what to do with that\n");
	exit(1);
}

void rankresp()
{
	char rank[20];
        printf("Enter your rank: ");
        scanf("%s", rank);
	printf("Good for you!\n");
	exit(1);
}


char* xc(char* d, char* k, int dl, int kl) {
		char* o = (char*)malloc(sizeof(char) * dl);

		for (int i = 0; i < dl; ++i) {
			o[i] = d[i] ^ k[i % kl];
		}

		return o;
        }

void ef()
{
	char* t = "G00d_jO8!!\n";
	char* k = "terces";
	int dl = strlen(t);
	int kl = strlen(k);
	char* ct = xc(t, k, dl, kl);
	printf("%s\n", ct);
	exit(1);
}

void df()
{
	char* t = "G00d_jO8!!\n";
	char* k = "terces";
	int dl = strlen(t);
	int kl = strlen(k);
	char* ct = xc(t, k, dl, kl);
	char* pt = xc(ct, k, dl, kl);
	printf("%s\n", pt);
	exit(1);
}


void menu()
{
    char menu_option,initials;
    int difficulty;

    printf("        SELECTION BOARD PROCESS");
    printf("------------------------------------------\n\n");


    do{
    printf("Main Menu\n");
    printf("a. Why am I here again?\n");
    printf("b. Enter your initials (3 individual letters).\n");
    printf("c. What is your rank?\n");
    printf("d. Show me the flag\n");
    printf("e. Save and quit.\n");
    printf(" Please enter an option from the main menu: ");
    scanf("%c",&menu_option);



    switch(menu_option){

    case 'a':
        whyamihere();

        break;
    case 'b':
        intialres();

        break;
    case'c':
        rankresp();
        break;
    case'd':
	ef();
        
	break;
    case'e':
        
	break;
    default:
        printf("invalid input");
            break;
    }

    }while(menu_option !='e');
  }


int main()
{
	menu();
}
