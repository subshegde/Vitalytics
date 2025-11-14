from fastapi import FastAPI, UploadFile, File, Form, HTTPException
from typing import List
import json
from schema import (
    DetectionRequest,
    DetectionResult,
    SuggestionRequest,
    SuggestionResult,
    NutritionRequest,
    NutritionsResponse,
    NutritionItemRequest,
    NutritionItem,
    NutritionItemDetailed,
    DietSummaryRequest,
    DietSummary,
    ProgressionRequest,
    ProgressionResult,
    FullSummaryRequest,
    FullSummary,
)
from llm import call_llm, create_image_payload, create_text_payload

from dependency import (
    DETAILED_NUTRITION_RESPONSE_SCHEMA,
    DIET_SUMMARY_RESPONSE_SCHEMA,
    FULL_SUMMARY_RESPONSE_SCHEMA,
    HOMEOPATHY_RESPONSE_SCHEMA,
    IMAGE_RESPONSE_SCHEMA,
    MEDICINE_RESPONSE_SCHEMA,
    NUTRITIONS_RESPONSE_SCHEMA,
    PROGRESSION_TRACKING_RESPONSE_SCHEMA,
    DETAILED_NUTRITION_RESPONSE_SCHEMA,
    DIET_SUMMARY_PROMPT,
    FULL_SUMMARY_PROMPT,
    HOMEOPATHY_PROMPT,
    IMAGE_PROMPT,
    MEDICINE_PROMPT,
    NUTRITIONS_PROMPT,
    PROGRESSION_TRACKING_PROMPT,
    DETAILED_NUTRITION_PROMPT,
)

from constraints import DEFAULT_USER

DB = {}

# 1. Core FastAPI App Initialization
app = FastAPI(
    title="Skin Disease Analyzer API",
    description="API for image-based skin disease detection and health recommendations.",
)


## 1. /api/detect-disease
@app.post("/api/detect-disease", response_model=DetectionResult, tags=["Detection"])
async def detect_disease(request: DetectionRequest):
    global DB
    request_dict = request.model_dump()
    filename = request_dict["filename"]
    query = request_dict["query"]
    request_payload = create_image_payload(IMAGE_PROMPT, query, [filename], IMAGE_RESPONSE_SCHEMA)
    
    # print("Image input payload: ", request_payload)
    response = call_llm(request_payload)
    response = json.loads(response)

    # print("Response: ", response)

    user_id = request_dict["user_id"]
    if(not DB.get(user_id)):
        DB[user_id] = DEFAULT_USER
    
    response = DetectionResult(
        detected_disease=response.get("detected_disease", "Azyma"),
        confidence_score=response.get("confidence_score", 0.6),
        description=response.get(
            "description",
            "Initial analysis suggests a high likelihood of **Azyma**.",
        ),
        precautionary_steps=response.get(
            "precautionary_steps",
            [
                "Avoid scratching the affected area.",
                "Keep the skin clean and dry.",
                "Consult a dermatologist for confirmation.",
            ],
        ),
    )
    DB[user_id]["disease_detected"] = response
    # print(f"DB[{user_id}]", DB[user_id])
    return response


## 2. /api/suggest
@app.post(
    "/api/suggest", response_model=SuggestionResult, tags=["Suggestions"]
)
async def suggest(request: SuggestionRequest):
    global DB
    """
    Provides suggestions for allopathic (conventional) medicines/homeopathy based on the detected disease.
    """
    # ⚠️ Placeholder: Logic needs to query a verified medical database.
    request_dict = request.model_dump()
    disease_type = request_dict["disease_type"]
    suggestion_type = request_dict["suggestion_type"]
    query = request_dict["query"]
    if (suggestion_type == "medicine"):
        system_prompt = MEDICINE_PROMPT
        response_format = MEDICINE_RESPONSE_SCHEMA
    else:
        system_prompt = HOMEOPATHY_PROMPT
        response_format = HOMEOPATHY_RESPONSE_SCHEMA

    system_prompt = system_prompt.format(DISEASE_TYPE=disease_type)

    request_payload = create_text_payload(system_prompt, query, response_format)
    print("Suggestion input payload: ", request_payload)
    
    response = call_llm(request_payload)
    response = json.loads(response)

    print("Response: ", response)

    suggestions = response.get("items", [{
            "name": "Hydrocortisone Cream (0.5%)",
            "dosage": "Apply twice daily",
            "note": "Low-potency topical steroid.",
        }])

    user_id = request_dict["user_id"]
    if(not DB.get(user_id)):
        DB[user_id] = DEFAULT_USER

    
    response = SuggestionResult(suggestion_type=suggestion_type, items=suggestions)

    if (suggestion_type == "medicine"):
        DB[user_id]["suggestion_medicine"] = response
    else:
        DB[user_id]["suggestion_homeopathy"] = response

    return response
    

## 3. /api/skin-health-neutrion
@app.post(
    "/api/skin-health-neutrion", response_model=NutritionsResponse, tags=["Nutrition"]
)
async def get_skin_health_nutrition(request: NutritionRequest):
    global DB
    """
    Lists key nutritional foods (fruits/vegetables/supplements) beneficial for general skin health.
    """
    # ⚠️ Placeholder: Logic needs to query a certified nutrition database.

    request_dict = request.model_dump()
    disease_type = request_dict["disease_type"]
    query = request_dict["query"]

    system_prompt = NUTRITIONS_PROMPT.format(DISEASE_TYPE=disease_type)

    request_payload = create_text_payload(system_prompt, query, NUTRITIONS_RESPONSE_SCHEMA)
    print("Suggestion input payload: ", request_payload)
    
    response = call_llm(request_payload)
    response = json.loads(response)

    print("Response: ", response)

    user_id = request_dict["user_id"]
    if(not DB.get(user_id)):
        DB[user_id] = DEFAULT_USER
    
    nutrition_list = []
    for nutrition in response["nutrients"]:
        nutrition_list.append(NutritionItem(
            name=nutrition.get("name"),
            benefit=nutrition.get("name"),
            source_foods=nutrition.get("source_foods")
        ))
    
    response = NutritionsResponse(
        report_title=response["report_title"],
        nutritions=nutrition_list
    )
    DB[user_id]["nutritions"] = response
    return response


## 4. /api/search
@app.post("/api/search", response_model=NutritionItemDetailed, tags=["Nutrition"])
async def search_nutrition_details(request: NutritionItemRequest):
    """
    Searches for detailed information on a specific nutrition item.
    """
    # ⚠️ Placeholder: Logic needs to query a certified nutrition database.
    request_dict = request.model_dump()
    name = request_dict["name"]
    disease_type = request_dict["disease_type"]
    query = request_dict["query"]

    system_prompt = DETAILED_NUTRITION_PROMPT.format(NAME=name, DISEASE_TYPE=disease_type)

    request_payload = create_text_payload(system_prompt, query, DETAILED_NUTRITION_RESPONSE_SCHEMA)

    print(f"Detailed Nutrition input payload: ", request_payload)
    response = call_llm(request_payload)
    response = json.loads(response)

    print("Response: ", response)

    return NutritionItemDetailed(
        item_name=response['item_name'],
        category=response['category'],
        description=response['description'],
        key_nutrients=response['key_nutrients']
    )

## 5. /api/diet-summary
@app.post("/api/diet-summary", response_model=DietSummary, tags=["Nutrition"])
async def get_diet_summary(request: DietSummaryRequest):
    global DB
    """
    Generates a high-level diet and meal plan summary based on the detected skin disease.
    """
    # ⚠️ Placeholder: Logic needs to query a certified nutrition database tailored to diseases.
    request_dict = request.model_dump()
    disease_type = request_dict["disease_type"]
    query = request_dict["query"]

    system_prompt = DIET_SUMMARY_PROMPT.format(DISEASE_TYPE=disease_type)

    request_payload = create_text_payload(system_prompt, query, DIET_SUMMARY_RESPONSE_SCHEMA)
    response = call_llm(request_payload)

    title = f"Anti-Inflammatory Diet Summary for {disease_type}"
    summary_text = "Focus on foods that reduce inflammation. This includes colorful fruits, vegetables, lean proteins, and healthy fats while reducing processed foods, sugar, and alcohol."

    suggested_meals = [
        {"meal": "Breakfast", "item": "Oatmeal with berries and flaxseed."},
        {"meal": "Lunch", "item": "Salmon salad with a side of mixed greens."},
        {
            "meal": "Dinner",
            "item": "Chicken breast with steamed broccoli and sweet potato.",
        },
    ]

    user_id = request_dict["user_id"]
    if(not DB.get(user_id)):
        DB[user_id] = DEFAULT_USER

    response =  DietSummary(
        title=title, summary_text=summary_text, suggested_meals=suggested_meals
    )

    DB[user_id]["diet_summary"] = response

    return response


## 6. /api/progression
@app.post("/api/progression", response_model=ProgressionResult, tags=["Tracking"])
async def track_progression(request: ProgressionRequest):
    global DB
    """
    Compares two skin images to track the progression of the disease over time.
    """
    request_dict = request.model_dump()
    filename1 = request_dict["filename1"]
    filename2 = request_dict["filename2"]
    curr_score = request_dict["curr_score"]
    query = request_dict["query"]

    system_prompt = PROGRESSION_TRACKING_PROMPT.format(CURR_SCORE=curr_score)

    request_payload = create_image_payload(system_prompt, query, [filename1, filename2], PROGRESSION_TRACKING_RESPONSE_SCHEMA)
    response = call_llm(request_payload)

    # Dummy logic: Assume the user is improving slightly
    progression_status = "Improving"
    change_description = "There is a noticeable reduction in redness and scaling compared to the initial image."
    suggested_adjustment = "Continue with the current medication and dietary plan. Apply moisturizer more frequently."

    user_id = request_dict["user_id"]
    if(not DB.get(user_id)):
        DB[user_id] = DEFAULT_USER

    response = ProgressionResult(
        analysis_date="2025-11-13",
        status=progression_status,
        change_description=change_description,
        suggested_adjustment=suggested_adjustment,
    )

    DB[user_id]["progression_tracking"] = response

    return response

## 8. /api/full-summary
@app.post("/api/full-summary", response_model=FullSummary, tags=["Summary"])
async def get_full_summary(request: FullSummaryRequest):
    global DB
    """
    Generates a comprehensive summary of the user's skin health, history, and all current recommendations.
    """
    request_dict = request.model_dump()

    user_id = request_dict["user_id"]
    if(not DB.get(user_id)):
        DB[user_id] = DEFAULT_USER

    query = request_dict["query"]

    system_prompt = FULL_SUMMARY_PROMPT.format(
        DISEASE_TYPE=DB[user_id]["disease_type"], 
        SUGGESTION_MEDICINE=DB[user_id]["suggestion_medicine"], 
        SUGGESTION_HOMEOPATHY=DB[user_id]["suggestion_homeopathy"], 
        NUTRITIONS=DB[user_id]["nutritions"],
        DIET_SUMMARY=DB[user_id]["diet_summary"],
        PROGRESSION_TRACKING=DB[user_id]["progression_tracking"],
    )

    request_payload = create_text_payload(system_prompt, query, FULL_SUMMARY_RESPONSE_SCHEMA)
    response = call_llm(request_payload)

    # Mock Data Aggregation
    mock_detected_disease = "Atopic Dermatitis (Eczema)"

    mock_meds = [{"name": "Hydrocortisone Cream (0.5%)", "dosage": "Apply twice daily"}]
    mock_homeo = [{"name": "Sulphur", "potency": "30C"}]
    mock_nutrition = [
        {"item": "Avocado", "benefit": "Skin barrier function"},
        {"item": "Omega-3", "benefit": "Reduce inflammation"},
    ]

    response = FullSummary(
        last_analysis_date="2025-11-10",
        disease_history=[
            "Eczema (Diagnosed 6 months ago)",
            "Mild Fungal Infection (Cleared 1 month ago)",
        ],
        current_status=f"Current condition is **{mock_detected_disease}**, showing slow but steady **improvement** based on the last progression check.",
        recommendations_snapshot={
            "Medicine": mock_meds,
            "Homeopathy": mock_homeo,
            "Nutrition": mock_nutrition,
        },
    )

    DB[user_id]["full_summary"] = response

    return response


# --- End of API Endpoints ---
