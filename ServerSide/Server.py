from flask import Flask, request
import pyautogui
import time

app = Flask(__name__)

@app.route('/GPT', methods=['POST'])
def handle_post():
    if request.is_json:
        content = request.get_json()  
        text = content.get('text', '')
        if text:
            time.sleep(2)
            pyautogui.typewrite(text)
            pyautogui.press('enter')
            return 'received', 200  
        else:
            return 'text not received', 400  
    else:
        return 'invalid request', 400  

if __name__ == '__main__':  
    app.run(host='0.0.0.0', port=5000)
