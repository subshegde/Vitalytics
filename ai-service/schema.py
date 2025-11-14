from pydantic import BaseModel
from typing import List, Optional


class DetectionRequest(BaseModel):
    """Model for the output of the /detect-disease endpoint."""

    user_id: str
    image_base64: str
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
    image: str

class KeyNutrient(BaseModel):
    nutrient: str
    amount: str

class NutritionItemDetailed(BaseModel):
    item_name: str
    category: str
    description: str
    key_nutrients: List[KeyNutrient]

class NutritionsResponse(BaseModel):
    report_title: str
    nutritions: List[NutritionItem]

class DietSummaryRequest(BaseModel):
    """Model for the overall diet summary."""

    user_id: str
    disease_type: str
    query: str


class MacroBreakdown(BaseModel):
    carbs: int
    protein: int
    fats: int

class DietSummary(BaseModel):
    """Model for the overall diet summary."""
    summary_text: str
    macro_breakdown: MacroBreakdown
    recommendations: List[str]

class ProgressionRequest(BaseModel):

    user_id: str
    image1_base64: str
    image2_base64: str
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
    metrics_tracked: List[ProgressionMetric]
    visual_notes: str

class FullSummaryRequest(BaseModel):
    """Model for the final full summary."""

    user_id: str
    query: str

class FullSummaryKeyMetric(BaseModel):
    diet_score: int
    progression_trend: str

class FullSUmmarySection(BaseModel):
    section_title: str
    brief_summary: str
    recommendation: str

class FullSummary(BaseModel):
    """Model for the final full summary."""

    analysis_date: str
    overall_status: str
    key_metrics: Optional[FullSummaryKeyMetric]
    sections: Optional[List[FullSUmmarySection]]

class ResponseImages(BaseModel):

    images: Optional[List[dict]]