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
        "disease_type":"", 
        "suggestion_medicine":"", 
        "suggestion_homeopathy":"", 
        "nutritions":"", 
        "progression_tracking":"", 
        "diet_summary":"",
        "full_summary": "",
}