import requests
import json
import os

from dotenv import load_dotenv
load_dotenv()

API_KEY = os.getenv("IMAGE_SEARCH_KEY")
CX_ID = os.getenv("IMAGE_SEARCH_CX")

def search_google_images(query, num_results=1):
    """
    Searches Google Images using the Custom Search JSON API.

    Args:
        query (str): The keyword or phrase to search for.
        num_results (int): The number of results to retrieve (max 10 per request).

    Returns:
        list: A list of dictionaries, each containing image details.
    """

    # The Custom Search URL endpoint
    url = "https://www.googleapis.com/customsearch/v1"

    # Parameters required for an image search
    params = {
        'q': query,
        'cx': CX_ID,
        'key': API_KEY,
        'searchType': 'image', # Crucial parameter to get image results
        'num': min(num_results, 1) # API limits results per query to 10
    }

    try:
        print(f"Searching for images of: '{query}'...")
        # Make the GET request to the Google Custom Search API
        response = requests.get(url, params=params)
        
        # Check for HTTP errors (like 404, 500, etc.)
        response.raise_for_status()

        data = response.json()

        # The actual image results are stored under the 'items' key
        items = data.get('items', [])

        if not items:
            print(f"No image results found for '{query}'.")
            # Check if there is an API error message
            if 'error' in data:
                print(f"API Error Details: {data['error'].get('message', 'Unknown API Error')}")
            return []

        results = []
        for item in items:
            # Extract relevant image information
            results.append({
                'title': item.get('title'),
                'source_url': item.get('link'),
                'display_link': item.get('displayLink'),
                'thumbnail_url': item.get('image', {}).get('thumbnailLink')
            })

        print(f"Successfully retrieved {len(results)} images.")
        return results

    except requests.exceptions.RequestException as e:
        print(f"An error occurred during the API request: {e}")
        return []
    except json.JSONDecodeError:
        print("Error: Could not parse JSON response from the API.")
        return []

# --- EXAMPLE USAGE ---
if __name__ == "__main__":
    search_term = "Golden Retriever puppy playing"

    # Perform the search
    image_list = search_google_images(search_term, num_results=5)

    # Print the results neatly
    if image_list:
        print("\n--- IMAGE SEARCH RESULTS ---")
        for i, img in enumerate(image_list, 1):
            print(f"\n{i}. Title: {img['title']}")
            print(f"   Source URL: {img['source_url']}")
            print(f"   Thumbnail: {img['thumbnail_url']}")
            print(f"   Domain: {img['display_link']}")
