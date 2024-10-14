import tkinter as tk
from PIL import Image, ImageTk
import pystray
from pystray import MenuItem, Icon
import threading

# Global variable to track the tray icon status
tray_icon = None

# Function to create the system tray icon
def create_tray_icon():
    global tray_icon
    icon_image = Image.open('C:/Users/inuse/Desktop/Encrypted/Python-VERSION.main/enc3.ico')  # Use the full path
    tray_icon = Icon("test_icon", icon_image, "ENCRYPTED.PY by avoe", menu=pystray.Menu(
        MenuItem("Show", show_window),
        MenuItem("Exit", exit_app)
    ))
    tray_icon.run()

# Function to show the main window
def show_window():
    root.deiconify()  # Show the window
    root.lift()  # Bring it to the front

# Function to exit the application
def exit_app():
    root.quit()

def scroll_text():
    global banner_text
    banner_text = banner_text[1:] + banner_text[0]
    banner_label.config(text=banner_text)
    root.after(100, scroll_text)

def close_app():
    root.withdraw()  # Hide the window instead of closing
    if not tray_icon:  # Check if the tray icon hasn't been created yet
        create_tray_icon()  # Start the tray icon

def center_window(window, width, height):
    screen_width = window.winfo_screenwidth()
    screen_height = window.winfo_screenheight()
    x = (screen_width // 2) - (width // 2)
    y = (screen_height // 2) - (height // 2)
    window.geometry(f'{width}x{height}+{x}+{y}')

def start_move(event):
    root.x = event.x
    root.y = event.y

def stop_move(event):
    root.x = None
    root.y = None

def do_move(event):
    deltax = event.x - root.x
    deltay = event.y - root.y
    new_x = root.winfo_x() + deltax
    new_y = root.winfo_y() + deltay
    root.geometry(f"+{new_x}+{new_y}")

# Create main tkinter window
root = tk.Tk()
root.title("ENCRYPTED.PY by avoe")
root.overrideredirect(True)  # Remove the default window frame

# Set a custom icon for the window using Pillow
icon_image = Image.open('C:/Users/inuse/Desktop/Encrypted/Python-VERSION.main/enc3.ico')  # Use the full path
icon_photo = ImageTk.PhotoImage(icon_image)
root.iconphoto(False, icon_photo)
root.configure(bg="black")

# Custom header with a black background
header_frame = tk.Frame(root, bg="black", relief="raised", bd=2)
header_frame.pack(fill="x", side="top")

# Add a custom title in the header
title_label = tk.Label(header_frame, text="ENCRYPTED.PY by avoe", bg="black", fg="white", font=("Jetbrains Mono", 10))
title_label.pack(side="left", padx=10)

# Add a close button to the custom header
close_button = tk.Button(header_frame, text="X", command=close_app, bg="black", fg="white", relief="flat")
close_button.pack(side="right", padx=5)

# Bind the mouse events to make the custom window draggable
header_frame.bind("<Button-1>", start_move)
header_frame.bind("<ButtonRelease-1>", stop_move)
header_frame.bind("<B1-Motion>", do_move)

# ASCII art header display
header_display = r"""
 _____ _   _  ____ ______   ______ _____ _____ ____   ______   __
| ____| \ | |/ ___|  _ \ \ / /  _ \_   _| ____|  _ \ |  _ \ \ / /
|  _| |  \| | |   | |_) \ V /| |_) || | |  _| | | | || |_) \ V / 
| |___| |\  | |___|  _ < | | |  __/ | | | |___| |_| ||  __/ | |  
|_____|_| \_|\____|_| \_\|_| |_|    |_| |_____|____(_)_|    |_|  
| |__  _   _    __ ___   _____   ___                             
| '_ \| | | |  / _` \ \ / / _ \ / _ \                            
| |_) | |_| | | (_| |\ V / (_) |  __/                            
|_.__/ \__, |  \__,_| \_/ \___/ \___|                            
       |___/                                                     
"""

# Add the ASCII art header to the window
header_label = tk.Label(root, text=header_display, font=("Jetbrains Mono", 10), justify="left", bg="black", fg="white")
header_label.pack()

# Banner text that scrolls
banner_text = "      Update Notes: Special Encryptions added for RIOT Game Accounts!         "
banner_label = tk.Label(root, text=banner_text, font=("Jetbrains Mono", 15), fg="green", bg="black")
banner_label.pack()

# Start the scrolling text
scroll_text()

# Set the window size and center it on the screen
window_width = 600
window_height = 600
center_window(root, window_width, window_height)

# Start the application in a separate thread to avoid blocking
threading.Thread(target=create_tray_icon, daemon=True).start()

root.mainloop()
