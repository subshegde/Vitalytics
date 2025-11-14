# Removed imports for OpenAI and constraints
import os
import json
from PIL import Image  # Import Python Imaging Library
import google.generativeai as genai  # Import the Google AI SDK
from typing import Optional, List, Dict, Any
from datetime import datetime
import requests
import time

from utils import load_image

from dotenv import load_dotenv
load_dotenv()

GEMINI_MODEL_TEXT_VISION = "gemini-2.5-flash-preview-09-2025" 
GEMINI_API_URL_BASE = "https://generativelanguage.googleapis.com/v1beta/models"

def create_text_payload_gemini(
    system_prompt: str, 
    user_prompt: str, 
    response_schema: Optional[Dict[str, Any]] = None
) -> Dict[str, Any]:
    """
    Creates a payload dictionary for text-only generation with optional JSON schema.
    
    In Gemini, the system prompt and structured output config are separate.
    """
    payload = {
        "contents": [
            {"role": "user", "parts": [{"text": user_prompt}]}
        ],
        "systemInstruction": {
            "parts": [{"text": system_prompt}]
        },
        "generationConfig": {}
    }
    
    if response_schema:
        # Structured output configuration for the REST API
        payload["generationConfig"] = {
            "responseMimeType": "application/json",
            "responseSchema": response_schema
        }

    return payload


def create_vision_payload_gemini(
    system_prompt: str, 
    user_prompt: str, 
    images: List[str], 
    response_schema: Optional[Dict[str, Any]] = None
) -> Dict[str, Any]:
    """
    Creates a multimodal (Vision) payload dictionary.
    Images are converted to inlineData (base64) parts.
    """
    
    # 1. Start with the user prompt part
    user_parts = [{"text": user_prompt}]

    # 2. Append image parts
    for image in images:
        # base64_image = load_image(path)
        if image:
            user_parts.append({
                "inlineData": {
                    "mimeType": "image/jpeg", # Assuming JPEG; change if needed
                    "data": image
                }
            })

    # 3. Construct the full payload
    payload = {
        "contents": [
            {"role": "user", "parts": user_parts}
        ],
        "systemInstruction": {
            "parts": [{"text": system_prompt}]
        },
        "generationConfig": {}
    }
    
    if response_schema:
        payload["generationConfig"] = {
            "responseMimeType": "application/json",
            "responseSchema": response_schema
        }

    return payload


# --- 2. Main Calling Function (Gemini Equivalent using REST API) ---

def call_llm_gemini(payload: Dict[str, Any]) -> Optional[str]:
    """
    Receives a complete, pre-formatted Gemini payload and makes the 
    REST API call using requests.
    
    Args:
        payload: The complete dictionary to be sent to the Gemini API.
                 
    Returns:
        The text content of the LLM's response, or None on failure.
    """
    key = os.getenv("GEMINI_API_KEY")
    if not key:
        print("GEMINI_API_KEY environment variable not set.")
        return None
        
    url = f"{GEMINI_API_URL_BASE}/{GEMINI_MODEL_TEXT_VISION}:generateContent?key={key}"
    
    # Simple retry logic for handling transient errors
    max_retries = 3
    delay = 1  # start delay in seconds
    
    for attempt in range(max_retries):
        try:
            headers = {'Content-Type': 'application/json'}
            
            # Make the API request
            response = requests.post(url, headers=headers, json=payload, timeout=60)
            
            # Check for HTTP errors
            response.raise_for_status() 
            
            resp_data = response.json()

            # Check for candidate text
            candidate = resp_data.get("candidates", [{}])[0]
            text = candidate.get("content", {}).get("parts", [{}])[0].get("text")
            
            if text is not None:
                return text
            
            # Handle empty response (e.g., safety block)
            print("Gemini response was empty or blocked.")
            return None

        except requests.exceptions.HTTPError as e:
            print(f"HTTP Error: {e.response.status_code} - {e.response.text}")
            if e.response.status_code in [429, 500, 503] and attempt < max_retries - 1:
                # Retry on rate limit or server errors
                print(f"Retrying in {delay}s...")
                time.sleep(delay)
                delay *= 2
            else:
                return None
        except Exception as e:
            print(f"An unexpected error occurred: {e}")
            return None
    
    return None