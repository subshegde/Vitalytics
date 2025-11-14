# 🩺 DermaScribe AI: Skin Health Backend

### A Gemini-powered FastAPI service for skin lesion analysis, treatment suggestions, and holistic health tracking.

![Python](https://img.shields.io/badge/Python-3.10%2B-%233776AB?style=for-the-badge&logo=python)
![FastAPI](https://img.shields.io/badge/FastAPI-%23009688?style=for-the-badge&logo=fastapi)
![Gemini](https://img.shields.io/badge/Google%20Gemini-%238E44AD?style=for-the-badge&logo=google-gemini)
![Pydantic](https://img.shields.io/badge/Pydantic-%23E92063?style=for-the-badge&logo=pydantic)
![Hackathon](https://img.shields.io/badge/Status-Hackathon%20Prototype-blue?style=for-the-badge)

## 📖 Overview

DermaScribe AI is a comprehensive, AI-driven backend service built for a hackathon. It's designed to provide a complete, holistic health journey for a user concerned about a potential skin condition.

Starting with an image of a skin lesion, the API uses the **Google Gemini** multimodal (Vision) model to perform an initial analysis. From there, it guides the user through a full cycle of care: suggesting conventional and homeopathic remedies, providing detailed nutritional advice, creating diet plans, and even tracking the lesion's progression over time by comparing images.

The service is built with **FastAPI** and features a modular design where all AI logic, system prompts, and response schemas are externalized from the main application code, allowing for rapid iteration.

## ✨ Core Features

* **Multimodal Skin Lesion Analysis:** Uses `gemini-2.5-flash` to analyze user-uploaded images of skin lesions, providing a potential (non-medical) identification, confidence score, and precautionary steps.

* **Holistic Treatment Suggestions:** Generates both allopathic (conventional) medicine and homeopathic remedy suggestions based on the detected condition.

* **Targeted Nutritional Guidance:** Recommends specific nutrients, fruits, and vegetables beneficial for the detected skin disease, complete with food images sourced from Google's Custom Search API.

* **Detailed Diet Planning:** Provides a high-level diet summary, including macro breakdowns and actionable recommendations.

* **Visual Progression Tracking:** Compares a new skin image against the previous one to generate a report on the condition's progression (e.g., "inflammation appears reduced").

* **Comprehensive Health Summary:** A capstone endpoint that synthesizes all user data (diagnosis, treatments, diet, progression) into a single, cohesive report.

* **Dynamic Prompt & Schema Management:** Loads all LLM system prompts from `.txt` files and JSON response schemas from `.json` files at runtime, making it easy to change the AI's behavior without touching the server logic.

## 🚀 Technology Stack

* **Backend:** [FastAPI](https://fastapi.tiangolo.com/)

* **AI Model:** [Google Gemini 2.5 Flash Preview](https://ai.google.dev/gemini-api) (via REST API)

* **Data Validation:** [Pydantic](https://docs.pydantic.dev/latest/)

* **Image Search:** [Google Custom Search JSON API](https://developers.google.com/custom-search/v1/overview)

* **Server:** [Uvicorn](https://www.uvicorn.org/)

* **Dependencies:** `requests`, `python-dotenv`, `Pillow`, `google-generativeai`

## 🏗️ Project Architecture

The service's architecture is designed for modularity and rapid prototyping.

1. **FastAPI (`main.py`):** Defines all API endpoints. It handles incoming HTTP requests, validates them using Pydantic models from `schema.py`, and routes them to the correct logic.

2. **Gemini Service (`llm_gemini.py`):** The core AI logic. It provides helper functions (`create_text_payload_gemini`, `create_vision_payload_gemini`) to construct the JSON payloads required by the Gemini REST API. The `call_llm_gemini` function executes the `requests.post` call with retry logic.

3. **Prompt & Schema Management (`dependency.py`):** This file is the "brain" of the AI. On startup, it reads all system prompts from the `/prompts` directory and all JSON schemas from the `/schema` directory, loading them into simple Python constants.

4. **AI Workflow:** When a request hits an endpoint:

   * `main.py` selects the correct prompt (e.g., `IMAGE_PROMPT`) and schema (e.g., `IMAGE_RESPONSE_SCHEMA`) from `dependency.py`.

   * It calls `create_vision_payload_gemini` (or text) to build the payload.

   * It passes this payload to `call_llm_gemini`.

   * The Gemini API receives the prompt and the required JSON schema, and is forced to return a perfectly structured JSON response, which is then parsed and sent back to the user.

5. **In-Memory "Database":** For the hackathon, the service uses a simple Python dictionary (`DB`) as an in-memory database to store a user's session data (their initial diagnosis, suggestions, images, etc.). This allows the `/api/full-summary` endpoint to aggregate all data for a specific `user_id`.

## ⚙️ Getting Started

### 1. Prerequisites

* Python 3.10+

* A Google Cloud project

* A [Gemini API Key](https://ai.google.dev/gemini-api/docs/api-key)

* A [Google Custom Search JSON API Key](https://developers.google.com/custom-search/v1/overview) and a [Search Engine ID (CX)](https://programmablesearchengine.google.com/controlpanel/all)

### 2. Installation & Setup

1. **Clone the repository:**

   ```bash
   git clone [https://github.com/subshegde/Vitalytics.git](https://github.com/subshegde/Vitalytics.git)
   cd VITALYTICS

2.  **Create a `requirements.txt` file:**
    Create a file named `requirements.txt` in the root directory and add the following dependencies:
    
    ```ini
    fastapi
    uvicorn[standard]
    pydantic
    python-dotenv
    requests
    Pillow
    google-generativeai
    ```

3.  **Create a virtual environment and install dependencies:**
    
    ```bash
    # Create the virtual environment
    python3 -m venv venv
    
    # Activate it (macOS/Linux)
    source venv/bin/activate
    # Or on Windows
    # .\venv\Scripts\activate
    
    # Install the requirements
    pip install -r requirements.txt
    ```

4.  **Create your `.env` file:**
    Create a file named `.env` in the root of the project and add your secret keys (based on `llm_gemini.py` and `image_search.py`):

    ```env
    GEMINI_API_KEY=YOUR_GEMINI_API_KEY_HERE
    IMAGE_SEARCH_KEY=YOUR_GOOGLE_CUSTOM_SEARCH_API_KEY_HERE
    IMAGE_SEARCH_CX=YOUR_CUSTOM_SEARCH_ENGINE_ID_HERE
    ```

5.  **Run the application:**

    ```bash
    uvicorn main:app --reload
    ```

    The API will be live at `http://127.0.0.1:8000`.

6.  **Explore the documentation:**
    Open your browser to `http://127.0.0.1:8000/docs` to see the interactive FastAPI (Swagger) documentation.

## 🗺️ API Endpoints

Here is a detailed breakdown of all available API endpoints, based on `main.py` and `schema.py`.

| Method | Endpoint | Description | Request Body | Success Response |
| :--- | :--- | :--- | :--- | :--- |
| `POST` | `/api/detect-disease` | **(Vision)** Analyzes a skin lesion image to identify a potential disease. | `DetectionRequest` | `DetectionResult` |
| `POST` | `/api/suggest` | Gets allopathic or homeopathic suggestions for a disease. | `SuggestionRequest` | `SuggestionResult` |
| `POST` | `/api/skin-health-neutrion` | Recommends nutrients and foods for a given disease. | `NutritionRequest` | `NutritionsResponse` |
| `POST` | `/api/search` | Gets detailed nutritional info for a single food item. | `NutritionItemRequest` | `NutritionItemDetailed` |
| `POST` | `/api/diet-summary` | Generates a diet plan and macro summary for a disease. | `DietSummaryRequest` | `DietSummary` |
| `POST` | `/api/progression` | **(Vision)** Compares two images to track disease progression. | `ProgressionRequest` | `ProgressionResult` |
| `POST` | `/api/full-summary` | Generates a comprehensive report from all stored user data. | `FullSummaryRequest` | `FullSummary` |
| `POST` | `/api/get-images` | Retrieves all images uploaded by a user in the current session. | `user_id: str` (in body) | `ResponseImages` |