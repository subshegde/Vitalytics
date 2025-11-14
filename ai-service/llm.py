from constraints import IMAGE_INPUT_FORMAT, TEXT_INPUT_FORMAT

def call_llm(payload):
    response = {"resposne": ""}
    return response


def create_image_payload(
    system_prompt, user_prompt, images, response_format
):
    input_payload = IMAGE_INPUT_FORMAT
    input_payload["messages"][0]["content"] = system_prompt
    input_payload["messages"][1]["content"][0]["text"] = user_prompt

    for image in images:
        base64_image = load_image(image)
        input_payload["messages"][1]["content"].append(
            {
                "type": "image_url",
                "image_url": {
                    "url": f"data:image/jpeg;base64,{base64_image}",
                    "detail": "high",
                },
            }
        )

    input_payload["response_format"] = response_format

    return input_payload


def create_text_payload(system_prompt, user_prompt, response_format):
    input_payload = TEXT_INPUT_FORMAT
    input_payload["messages"][0]["content"] = system_prompt
    input_payload["messages"][1]["content"] = user_prompt
    input_payload["response_format"] = response_format

    return input_payload


def load_image(filename):
    image = "base64_encoding"
    return image
