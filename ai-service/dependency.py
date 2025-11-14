import json

# Response Schema
with open("schema/detailed_nutrition_response_schema.json", "r") as file:
    DETAILED_NUTRITION_RESPONSE_SCHEMA = json.load(file)

with open("schema/diet_summary_response_schema.json", "r") as file:
    DIET_SUMMARY_RESPONSE_SCHEMA = json.load(file)

with open("schema/full_summary_response_schema.json", "r") as file:
    FULL_SUMMARY_RESPONSE_SCHEMA = json.load(file)

with open("schema/homeopathy_response_schema.json", "r") as file:
    HOMEOPATHY_RESPONSE_SCHEMA = json.load(file)

with open("schema/image_response_schema.json", "r") as file:
    IMAGE_RESPONSE_SCHEMA = json.load(file)

with open("schema/medicine_response_schema.json", "r") as file:
    MEDICINE_RESPONSE_SCHEMA = json.load(file)

with open("schema/nutritions_response_schema.json", "r") as file:
    NUTRITIONS_RESPONSE_SCHEMA = json.load(file)

with open("schema/progression_tracking_response_schema.json", "r") as file:
    PROGRESSION_TRACKING_RESPONSE_SCHEMA = json.load(file)

with open("schema/detailed_nutrition_response_schema.json", "r") as file:
    DETAILED_NUTRITION_RESPONSE_SCHEMA = json.load(file)

# Prompts
with open("prompts/diet_summary_prompt.txt", "r") as file:
    DIET_SUMMARY_PROMPT = file.read()

with open("prompts/full_summary_prompt.txt", "r") as file:
    FULL_SUMMARY_PROMPT = file.read()

with open("prompts/homeopathy_prompt.txt", "r") as file:
    HOMEOPATHY_PROMPT = file.read()

with open("prompts/image_prompt.txt", "r") as file:
    IMAGE_PROMPT = file.read()

with open("prompts/medicine_prompt.txt", "r") as file:
    MEDICINE_PROMPT = file.read()

with open("prompts/nutritions_prompt.txt", "r") as file:
    NUTRITIONS_PROMPT = file.read()

with open("prompts/progression_tracking_prompt.txt", "r") as file:
    PROGRESSION_TRACKING_PROMPT = file.read()

with open("prompts/detailed_nutrition_prompt.txt", "r") as file:
    DETAILED_NUTRITION_PROMPT = file.read()
