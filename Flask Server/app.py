from flask import Flask, request, jsonify
import requests
import google.generativeai as genai

app = Flask(__name__)

@app.route('/process-text', methods=['POST'])
def process_text():
    # Step 2: Parse JSON input
    data = request.get_json()
    print(data)
    user_input = data.get('text')
    
    if not user_input:
        return jsonify({'error': 'No text provided'}), 400
    
    genai.configure(api_key="***REMOVED***")

    # Set up the model
    generation_config = {
    "temperature": 1,
    "top_p": 0.95,
    "top_k": 0,
    "max_output_tokens": 8192,
    }

    safety_settings = [
    {
        "category": "HARM_CATEGORY_HARASSMENT",
        "threshold": "BLOCK_MEDIUM_AND_ABOVE"
    },
    {
        "category": "HARM_CATEGORY_HATE_SPEECH",
        "threshold": "BLOCK_MEDIUM_AND_ABOVE"
    },
    {
        "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
        "threshold": "BLOCK_MEDIUM_AND_ABOVE"
    },
    {
        "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
        "threshold": "BLOCK_MEDIUM_AND_ABOVE"
    },
    ]



    model = genai.GenerativeModel(model_name="gemini-1.5-pro-latest",
                                generation_config=generation_config,
                                safety_settings=safety_settings)

    # prompt_parts = [
    # "{\n \"prompt\": \" Take these data as the user's background information on his mental health summary. And answer the questions the user based on the user's emotions and mental health well beingness. The user says  \"" + user_input + " \" give him a response based on his mental health summary which is provided in the data. }"
    # ]

    prompt_parts = [
    "{\n \"prompt\": \" Give response to this user. The user says  \"" + user_input + " \"}"
    ]
    

    response = model.generate_content(prompt_parts)
    response = response.text
    return response

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)