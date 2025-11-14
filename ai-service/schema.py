from pydantic import BaseModel
from typing import List, Optional


class DetectionRequest(BaseModel):
    """Model for the output of the /detect-disease endpoint."""

    user_id: str
    filename: str
    query: str


class DetectionResult(BaseModel):
    """Model for the output of the /detect-disease endpoint."""

    detected_disease: str
    confidence_score: float
    description: str
    precautionary_steps: List[str]


class SuggestionRequest(BaseModel):
    """Model for medicine/homeopathy suggestions."""

    user_id: str
    suggestion_type: str
    disease_type: str
    query: str

class SuggestionResult(BaseModel):
    """Model for medicine/homeopathy suggestions."""

    suggestion_type: str
    items: List[dict]


class NutritionRequest(BaseModel):
    """Model for an individual nutrition item (e.g., a fruit or vegetable)."""

    user_id: str
    disease_type: str
    query: str

class NutritionItemRequest(BaseModel):
    name: str
    disease_type: str
    query: str

class NutritionItem(BaseModel):
    """Model for an individual nutrition item (e.g., a fruit or vegetable)."""

    name: str
    benefit: str
    source_foods: List[str]

class NutritionItemDetailed(BaseModel):
    title: str

class NutritionsResponse(BaseModel):
    report_title: str
    nutritions: List[NutritionItem]

class DietSummaryRequest(BaseModel):
    """Model for the overall diet summary."""

    user_id: str
    disease_type: str
    query: str

class DietSummary(BaseModel):
    """Model for the overall diet summary."""

    title: str
    summary_text: str
    suggested_meals: List[dict]

class ProgressionRequest(BaseModel):

    user_id: str
    filename1: str
    filename2: str
    curr_score: float
    query: str

class ProgressionMetric(BaseModel):
    metric_name: str
    change_description: str
    confidence_score: float

class ProgressionResult(BaseModel):
    """Model for the progression tracking result."""

    analysis_date: str
    overall_change: str
    metrics_tracked: ProgressionMetric
    visual_notes: str

class FullSummaryRequest(BaseModel):
    """Model for the final full summary."""

    user_id: str
    query: str

class FullSummary(BaseModel):
    """Model for the final full summary."""

    last_analysis_date: str
    disease_history: List[str]
    current_status: str
    recommendations_snapshot: dict  # Holds latest medicine, homeopathy, and nutrition
