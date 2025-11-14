import base64
import json
from datetime import datetime
from typing import Optional, List, Dict, Any

def load_image(file_path: str) -> Optional[str]:
    """
    Loads an image file from file_path, encodes it to base64,
    and returns it as a string.
    """
    try:
        # Open the image file in binary read mode
        with open(file_path, "rb") as image_file:
            # Read the file bytes, encode to base64, and decode to utf-8 string
            return base64.b64encode(image_file.read()).decode('utf-8')
    except FileNotFoundError:
        print(f"Error: Image file not found at {file_path}")
        return None
    except Exception as e:
        print(f"Error loading image {file_path}: {e}")
        return None

def get_current_date_and_time():
    """
    Retrieves and formats the current date and time.
    """
    # Get the current date and time object
    now = datetime.now()
    
    # Format the date and time into a readable string
    # %Y = Year, %m = Month, %d = Day
    # %H = Hour (24-hour), %M = Minute, %S = Second
    date_string = now.strftime("Today's Date: %Y-%m-%d\nCurrent Time: %H:%M:%S")
    
    return date_string