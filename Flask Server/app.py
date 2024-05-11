from flask import Flask, request, jsonify
import requests
import google.generativeai as genai
import os
api_key = os.environ.get('API_KEY')

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


@app.route('/process-journal', methods=['POST'])
def process_journal():
    # Step 2: Parse JSON input
    data = request.get_json()
    print(data)
    user_input = data.get('text')
    
    if not user_input:
        return jsonify({'error': 'No text provided'}), 400
    
    genai.configure(api_key=api_key)

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

    prompt_parts = [    "{\n \"prompt\": \" User input in form of text is going to be saved as \"journal\". This journal consists instances of the user emotions, about the proceedings of their day and a mixuture of emotions they are feeling. This \"journal\" is a depiction of their emotions, and hence it will contain various emotions that the user goes through like for example happy, sad,  happy, disappointed and much more. these are some important keywords that we are using to analyse the user mindset. the emotional parameters that we are going to use to depict the overall mindset of the user are \"happy\", \"fear\", \"anxious\",\"anger\". Depending on the user\"journal\" and various follow up questions asked from the user, give appropriate percentage scoring for these parameters like\"happy\", \"fear\",\"anxious\",\"anger\". These must be analysed like how much percent the user is happy, how much he is anxious and much more and at the end display one  \"dominant\" emotion which like average of the other four parameters \"happy\",\"anxious\",\"fear\",\"anger\". exaples of some \"dominant\" emotions are \"relaxed\",\"excited\",\"uneasy\",\"depressed\". Similar to this i want to depict the overall mood of the user. Now for the questions asked, frame the questions focusing on the result of the user scenario. For instance if the user input is \" i have a test tommorow for which i am scared\" then the questions should be like \"how did you do the test?\", \"was the test difficult?\",\"how do you feel after the test?\". ensure to sk feedback questions related to the user input. it is essential. The user's journal for today is " + journal_text  +" \"}"     ]
    

    response = model.generate_content(prompt_parts)
    response = response.text
    return response

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)