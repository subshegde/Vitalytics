from fastapi import FastAPI, UploadFile, File, Form, HTTPException
from fastapi.responses import JSONResponse
from fastapi import status
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
    ResponseImages,
)
# from llm_open_ai import (
#     call_llm_openai, 
#     create_text_payload, 
#     create_image_payload
# )

from llm_gemini import (
    call_llm_gemini,
    create_text_payload_gemini,
    create_vision_payload_gemini
)

from utils import get_current_date_and_time, load_image

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
    try:
        request_dict = request.model_dump()
        image_base64 = request_dict["image_base64"]
        if ".jpeg" in image_base64 or ".jpg" in image_base64 or ".png" in image_base64:
            image_base64 = load_image(image_base64)
        query = request_dict["query"]
        user_id = request_dict["user_id"]
        if(not DB.get(user_id)):
            DB[user_id] = DEFAULT_USER
        elif DB[user_id]["disease_detected"]:
            return DB[user_id]["disease_detected"]

        request_payload = create_vision_payload_gemini(IMAGE_PROMPT, query, [image_base64], IMAGE_RESPONSE_SCHEMA)
        
        print("Image input payload: ", request_payload)
        response = call_llm_gemini(request_payload)
        response = json.loads(response)

        print("Response: ", response)

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
        DB[user_id]['images'].append({
            "image": image_base64,
            "confidence_score": response.confidence_score
        })
        # print(f"DB[{user_id}]", DB[user_id])
        return response
    except Exception as e:
        # Get the class name of the exception
        error_type = type(e).__name__ 
        
        # Return a JSONResponse containing the raw exception details
        return JSONResponse(
            status_code=status.HTTP_400_BAD_REQUEST,  # Using 400 for generic client error
            content={
                "status": "error",
                "type": error_type,
                "message": str(e),
                "note": "Generic handler used to return raw exception details."
            },
        )


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
    try:
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

        user_id = request_dict["user_id"]
        if(not DB.get(user_id)):
            DB[user_id] = DEFAULT_USER
        elif suggestion_type == "medicine" and DB[user_id]["suggestion_medicine"]:
            return DB[user_id]["suggestion_medicine"]
        elif suggestion_type == "homeopathy" and DB[user_id]["suggestion_homeopathy"]:
            return DB[user_id]["suggestion_homeopathy"]

        system_prompt = system_prompt.format(DISEASE_TYPE=disease_type)

        request_payload = create_text_payload_gemini(system_prompt, query, response_format)
        print("Suggestion input payload: ", request_payload)
        
        response = call_llm_gemini(request_payload)
        response = json.loads(response)

        print("Response: ", response)

        suggestions = response.get("items", [{
                "name": "Hydrocortisone Cream (0.5%)",
                "dosage": "Apply twice daily",
                "note": "Low-potency topical steroid.",
            }])

        response = SuggestionResult(suggestion_type=suggestion_type, items=suggestions)

        if (suggestion_type == "medicine"):
            DB[user_id]["suggestion_medicine"] = response
        else:
            DB[user_id]["suggestion_homeopathy"] = response

        return response

    except Exception as e:
        # Get the class name of the exception
        error_type = type(e).__name__ 
        
        # Return a JSONResponse containing the raw exception details
        return JSONResponse(
            status_code=status.HTTP_400_BAD_REQUEST,  # Using 400 for generic client error
            content={
                "status": "error",
                "type": error_type,
                "message": str(e),
                "note": "Generic handler used to return raw exception details."
            },
        )
    

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

    try:
        request_dict = request.model_dump()
        disease_type = request_dict["disease_type"]
        query = request_dict["query"]
        user_id = request_dict["user_id"]
        if(not DB.get(user_id)):
            DB[user_id] = DEFAULT_USER
        elif DB[user_id]["suggestion_nutritions"]:
            return DB[user_id]["suggestion_nutritions"]

        system_prompt = NUTRITIONS_PROMPT.format(DISEASE_TYPE=disease_type)

        request_payload = create_text_payload_gemini(system_prompt, query, NUTRITIONS_RESPONSE_SCHEMA)
        print("Suggestion input payload: ", request_payload)
        
        response = call_llm_gemini(request_payload)
        response = json.loads(response)

        print("Response: ", response)

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
        DB[user_id]["suggestion_nutritions"] = response
        return response
    
    except Exception as e:
        # Get the class name of the exception
        error_type = type(e).__name__ 
        
        # Return a JSONResponse containing the raw exception details
        return JSONResponse(
            status_code=status.HTTP_400_BAD_REQUEST,  # Using 400 for generic client error
            content={
                "status": "error",
                "type": error_type,
                "message": str(e),
                "note": "Generic handler used to return raw exception details."
            },
        )


## 4. /api/search
@app.post("/api/search", response_model=NutritionItemDetailed, tags=["Nutrition"])
async def search_nutrition_details(request: NutritionItemRequest):
    """
    Searches for detailed information on a specific nutrition item.
    """
    # ⚠️ Placeholder: Logic needs to query a certified nutrition database.
    try:
        request_dict = request.model_dump()
        name = request_dict["name"]
        disease_type = request_dict["disease_type"]
        query = request_dict["query"]

        system_prompt = DETAILED_NUTRITION_PROMPT.format(NAME=name, DISEASE_TYPE=disease_type)

        request_payload = create_text_payload_gemini(system_prompt, query, DETAILED_NUTRITION_RESPONSE_SCHEMA)

        print(f"Detailed Nutrition input payload: ", request_payload)
        response = call_llm_gemini(request_payload)
        response = json.loads(response)

        print("Response: ", response)

        return NutritionItemDetailed(
            item_name=response['item_name'],
            category=response['category'],
            description=response['description'],
            key_nutrients=response['key_nutrients']
        )
    
    except Exception as e:
        # Get the class name of the exception
        error_type = type(e).__name__ 
        
        # Return a JSONResponse containing the raw exception details
        return JSONResponse(
            status_code=status.HTTP_400_BAD_REQUEST,  # Using 400 for generic client error
            content={
                "status": "error",
                "type": error_type,
                "message": str(e),
                "note": "Generic handler used to return raw exception details."
            },
        )

## 5. /api/diet-summary
@app.post("/api/diet-summary", response_model=DietSummary, tags=["Nutrition"])
async def get_diet_summary(request: DietSummaryRequest):
    global DB
    """
    Generates a high-level diet and meal plan summary based on the detected skin disease.
    """
    # ⚠️ Placeholder: Logic needs to query a certified nutrition database tailored to diseases.
    try:
        request_dict = request.model_dump()
        disease_type = request_dict["disease_type"]
        query = request_dict["query"]
        user_id = request_dict["user_id"]
        if(not DB.get(user_id)):
            DB[user_id] = DEFAULT_USER
        elif DB[user_id]["diet_summary"]:
            return DB[user_id]["diet_summary"]

        system_prompt = DIET_SUMMARY_PROMPT.format(DISEASE_TYPE=disease_type)

        request_payload = create_text_payload_gemini(system_prompt, query, DIET_SUMMARY_RESPONSE_SCHEMA)
        response = call_llm_gemini(request_payload)
        response = json.loads(response)

        print("Response: ", response)

        response =  DietSummary(
            summary_text=response.get("summary_text"), 
            macro_breakdown=response.get("macro_breakdown"), 
            recommendations=response.get("recommendations")
        )

        DB[user_id]["diet_summary"] = response

        return response

    except Exception as e:
        # Get the class name of the exception
        error_type = type(e).__name__ 
        
        # Return a JSONResponse containing the raw exception details
        return JSONResponse(
            status_code=status.HTTP_400_BAD_REQUEST,  # Using 400 for generic client error
            content={
                "status": "error",
                "type": error_type,
                "message": str(e),
                "note": "Generic handler used to return raw exception details."
            },
        )


## 6. /api/progression
@app.post("/api/progression", response_model=ProgressionResult, tags=["Tracking"])
async def track_progression(request: ProgressionRequest):
    global DB
    """
    Compares two skin images to track the progression of the disease over time.
    """
    try:
        request_dict = request.model_dump()
        image1_base64 = request_dict["image1_base64"]
        image2_base64 = request_dict["image2_base64"]

        if ".jpeg" in image1_base64 or ".jpg" in image1_base64 or ".png" in image1_base64:
            image1_base64 = load_image(image1_base64)

        if ".jpeg" in image2_base64 or ".jpg" in image2_base64 or ".png" in image2_base64:
            image2_base64 = load_image(image2_base64)

        curr_score = request_dict["curr_score"]
        query = request_dict["query"]

        system_prompt = PROGRESSION_TRACKING_PROMPT.format(CURR_SCORE=curr_score)

        request_payload = create_vision_payload_gemini(system_prompt, query, [image1_base64, image2_base64], PROGRESSION_TRACKING_RESPONSE_SCHEMA)
        print("Suggestion input payload: ", request_payload)
        
        response = call_llm_gemini(request_payload)
        response = json.loads(response)

        print("Response: ", response)

        user_id = request_dict["user_id"]
        if(not DB.get(user_id)):
            DB[user_id] = DEFAULT_USER

        average_metric = sum(metric['confidence_score'] for metric in response.get("metrics_tracked", [])) / len(response.get("metrics_tracked", []))

        response = ProgressionResult(
            analysis_date=get_current_date_and_time(),
            overall_change=response.get("overall_change"),
            metrics_tracked=response.get("metrics_tracked", []),
            visual_notes=response.get("visual_notes"),
        )
        
        DB[user_id]["progression_tracking"] = response
        DB[user_id]['images'].append({
            "image": image2_base64,
            "confidence_score": average_metric
        })

        return response
    
    except Exception as e:
        # Get the class name of the exception
        error_type = type(e).__name__ 
        
        # Return a JSONResponse containing the raw exception details
        return JSONResponse(
            status_code=status.HTTP_400_BAD_REQUEST,  # Using 400 for generic client error
            content={
                "status": "error",
                "type": error_type,
                "message": str(e),
                "note": "Generic handler used to return raw exception details."
            },
        )

## 8. /api/full-summary
@app.post("/api/full-summary", response_model=FullSummary, tags=["Summary"])
async def get_full_summary(request: FullSummaryRequest):
    global DB
    """
    Generates a comprehensive summary of the user's skin health, history, and all current recommendations.
    """
    try:
        request_dict = request.model_dump()
        query = request_dict["query"]
        user_id = request_dict["user_id"]
        if(not DB.get(user_id)):
            DB[user_id] = DEFAULT_USER
        elif DB[user_id]["full_summary"]:
            return DB[user_id]["full_summary"]

        system_prompt = FULL_SUMMARY_PROMPT.format(
            DISEASE_TYPE=DB[user_id]["disease_type"], 
            SUGGESTION_MEDICINE=DB[user_id]["suggestion_medicine"], 
            SUGGESTION_HOMEOPATHY=DB[user_id]["suggestion_homeopathy"], 
            SUGGESTION_NUTRITIONS=DB[user_id]["suggestion_nutritions"],
            DIET_SUMMARY=DB[user_id]["diet_summary"],
            PROGRESSION_TRACKING=DB[user_id]["progression_tracking"],
        )

        request_payload = create_text_payload_gemini(system_prompt, query, FULL_SUMMARY_RESPONSE_SCHEMA)
        print("Suggestion input payload: ", request_payload)
        
        response = call_llm_gemini(request_payload)
        response = json.loads(response)

        print("Response: ", response)

        response = FullSummary(
            analysis_date=get_current_date_and_time(),
            overall_status=response.get("overall_status"),
            key_metrics=response.get("key_metrics"),
            sections=response.get("sections"),
        )

        DB[user_id]["full_summary"] = response

        return response
    
    except Exception as e:
        # Get the class name of the exception
        error_type = type(e).__name__ 
        
        # Return a JSONResponse containing the raw exception details
        return JSONResponse(
            status_code=status.HTTP_400_BAD_REQUEST,  # Using 400 for generic client error
            content={
                "status": "error",
                "type": error_type,
                "message": str(e),
                "note": "Generic handler used to return raw exception details."
            },
        )
    
## 9. /api/get-images
@app.post("/api/get-images", response_model=ResponseImages, tags=["images"])
async def get_images(user_id: str):
    """
    Generates a comprehensive summary of the user's skin health, history, and all current recommendations.
    """
    try:
        if(not DB.get(user_id)):
            return ResponseImages(
                images=[]
            )
        elif DB[user_id]["images"]:
            return ResponseImages(
                images=DB[user_id]["images"]
            )
    
    except Exception as e:
        # Get the class name of the exception
        error_type = type(e).__name__ 
        
        # Return a JSONResponse containing the raw exception details
        return JSONResponse(
            status_code=status.HTTP_400_BAD_REQUEST,  # Using 400 for generic client error
            content={
                "status": "error",
                "type": error_type,
                "message": str(e),
                "note": "Generic handler used to return raw exception details."
            },
        )

# --- End of API Endpoints ---
