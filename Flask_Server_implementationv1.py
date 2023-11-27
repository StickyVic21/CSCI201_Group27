# https://dev.to/terieyenike/creating-apis-with-flask-and-testing-in-postman-2ojn
# link to how to run flask api

# We have to create a virtual environment
# Step 1: Install Python: If you don't already have Python installed, download and install it from python.org.
# Step 2: In terminal, where you would want the environment folder located, run python -m venv <name-of-project>
# Step 3: Next, navigate to the project directory to activate the virtual environment.
        ## To be sure you are referencing the right shell, check out 
        # https://docs.python.org/3/library/venv.html#how-venvs-work 
        # for the command based on your shell.
            # I have windows so it was 	
            # C:\> CSCI_201_FinalProj\Scripts\activate.bat
# Step 4: After activation, your command prompt will show the name of the environment, indicating that you are 
    # working within it.
        ## (flask-apis) (base)  ✝  ~/Desktop/flask-apis 
# Step 5: Next run pip install flask
        ## confirm installation by running: pip show flask
# Step 6: pip install mysql-connector-python
# Step 7: Move the flask_api python script into the virtual environment folder
# Step 8: flask --app app --debug run
        ## app: is the name of the file that contains the application code. 
        # If you named the file hello.py, you must replace app with hello
            # flask --app hello --debug run
# Step 9: Terminal should output something similar to this:
    # Serving Flask app 'app'
    #  * Debug mode: on
    # WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
    #  * Running on http://127.0.0.1:5000
    # Press CTRL+C to quit
    #  * Restarting with stat
    #  * Debugger is active!
    #  * Debugger PIN: 100-724-825

from flask import Flask, request, jsonify
import mysql.connector

app = Flask(__name__)

# Database connection details
db_config = {
    'user': 'root',
    'password': 'root',
    'host': 'localhost',
    'database': 'UserTable'
}

@app.route('/submit_score', methods=['POST'])
def submit_score():
    data = request.json
    user_id = data['userID']
    new_score = data['score']

    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()

    # Fetch top 3 scores
    cursor.execute("SELECT score1, score2, score3 FROM Users WHERE userID = %s", (user_id,))
    scores = cursor.fetchone()

    # Logic to check if new score is higher and update
    # ...
    if scores:
        score_list = list(scores)
        score_list.append(new_score)
        score_list.sort(reverse=True)  # Sort scores in descending order

        # Update only if new score is among the top 3
        if new_score in score_list[:3]:
            # Update top 3 scores
            update_query = "UPDATE Users SET score1 = %s, score2 = %s, score3 = %s WHERE userID = %s"
            cursor.execute(update_query, (score_list[0], score_list[1], score_list[2], user_id))
            conn.commit()

    conn.commit()
    cursor.close()
    conn.close()

    return jsonify({'status': 'success'})

if __name__ == '__main__':
    app.run(debug=True)
