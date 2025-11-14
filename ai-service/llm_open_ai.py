import os
from openai import OpenAI
from typing import Optional, Dict, Any

from constraints import IMAGE_INPUT_FORMAT, TEXT_INPUT_FORMAT
from utils import load_image

from dotenv import load_dotenv
load_dotenv()

def call_llm_openai(payload: Dict[str, Any]) -> Optional[str]:
    """
    Receives a complete, pre-formatted payload and makes the 
    OpenAI API call. This single function handles both text and vision.
    
    Args:
        payload: The complete dictionary to be sent to the OpenAI API.
                 Must include "model", "messages", etc.
                 
    Returns:
        The text content of the LLM's response, or None on failure.
    """
    key = os.getenv("OPENAI_API_KEY")
    if not key or "REPLACE_WITH_YOUR_KEY" in key:
        print("OPENAI_API_KEY environment variable not set or is invalid.")
        return None
        
    try:
        client = OpenAI(api_key=key)
        
        # The payload is already built, so we just pass it
        # using dictionary unpacking.
        resp = client.chat.completions.create(**payload)
        
        return resp.choices[0].message.content

    except Exception as e:
        print(f"Error calling OpenAI: {e}")
        return None
    
def create_text_payload(system_prompt, user_prompt, response_format):
    input_payload = TEXT_INPUT_FORMAT
    input_payload["messages"][0]["content"] = system_prompt
    input_payload["messages"][1]["content"] = user_prompt
    
    # Add response_format only if it's provided
    if response_format:
        input_payload["response_format"] = response_format

    return input_payload

def create_image_payload(
    system_prompt, user_prompt, images, response_format
):
    input_payload = IMAGE_INPUT_FORMAT
    input_payload["messages"][0]["content"] = system_prompt
    input_payload["messages"][1]["content"][0]["text"] = user_prompt

    for image in images:
        base64_image = load_image(image)
        if base64_image:
            input_payload["messages"][1]["content"].append(
                {
                    "type": "image_url",
                    "image_url": {
                        "url": f"data:image/jpeg;base64,{base64_image}",
                        "detail": "high",
                    },
                }
            )

    if response_format:
        input_payload["response_format"] = response_format

    return input_payload