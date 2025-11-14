IMAGE_INPUT_FORMAT = {
    "model": "gpt-4o",
    "messages": [
        {
            "role": "system",
            "content": "",
        },
        {
            "role": "user",
            "content": [
                {
                    "type": "text",
                    "text": "",
                },
            ],
        },
    ],
    "response_format": None,
    "max_tokens": 1024,
}

TEXT_INPUT_FORMAT = {
    "model": "gpt-4o-mini",
    "messages": [
        {
            "role": "system",
            "content": "",
        },
        {
            "role": "user",
            "content": "",
        },
    ],
    "response_format": None,
    "max_tokens": 768,
}

DEFAULT_USER = {
        "disease_type": None, 
        "suggestion_medicine": None, 
        "suggestion_homeopathy":None, 
        "suggestion_nutritions":None, 
        "progression_tracking":None, 
        "diet_summary":None,
        "full_summary": None,
        "images": []
}