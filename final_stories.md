You will be using the “Open Brewery DB” to find a quantity of breweries in a destination city that the user provides. Presume that your user will give a known “good” location. (you can handle edge cases later)

Your endpoint should follow this format:
GET /api/v1/breweries?location=denver,co&quantity=5

please do not deviate from the names of the endpoint or query parameter, be sure it is called “breweries” and “location” and “quantity”, respectively
quantity should be a positive integer greater than 0

Your API will return:
the destination city
the forecast in that city right now
breweries in the city
Your response should be in the format below:
GET /api/v1/breweries?location=denver,co&quantity=5

{
  "data": {
    "id": "null",
    "type": "breweries",
    "attributes": {
      "destination": "denver,co",
      "forecast": {
        "summary": "Cloudy with a chance of meatballs",
        "temperature": "83 F"
      },
      "breweries": [
        {
          "id": 10129,
          "name": "Denver Beer Co Olde Town Arvada",
          "brewery_type": "micro"
        },
        {
          "id": 12906,
          "name": "New Image Brewing Co",
          "brewery_type": "brewpub"
        },
        { ... same format for breweries 3, 4 and 5 ... }
      ]
    }
  }
}