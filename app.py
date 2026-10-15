

from flask import Flask, request, render_template_string, Response
import os
import mysql.connector

app = Flask(__name__)

PAGE = """
<!DOCTYPE html>
<html>
<head>
    <title>Canteen Smart Token System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 1000px;
            margin: 40px auto;
            padding: 20px;
            background: #f4f6f8;
        }
        h1 { color: #243b55; }
        textarea {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
        }
        button {
            padding: 10px 20px;
            background: #243b55;
            color: white;
            border: none;
            cursor: pointer;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            background: white;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: left;
        }
        th { background: #dce6f1; }
        .error { color: #c62828; }
    </style>
</head>
<body>
    <h1>Canteen Smart Token System</h1>
    <p>Enter a read-only MySQL command:</p>
    <form method="post">
        <textarea name="sql" rows="6" required>{{ sql }}</textarea>
        <br><br>
        <button type="submit">Execute SQL</button>
    </form>

    {% if error %}
        <p class="error">{{ error }}</p>
    {% endif %}

    {% if columns %}
    <table>
        <tr>
            {% for c in columns %}
                <th>{{ c }}</th>
            {% endfor %}
        </tr>
        {% for row in rows %}
        <tr>
            {% for value in row %}
                <td>{{ value if value is not none else 'NULL' }}</td>
            {% endfor %}
        </tr>
        {% endfor %}
    </table>
    <p>{{ rows|length }} rows returned.</p>
    {% elif message %}
        <p>{{ message }}</p>
    {% endif %}
</body>
</html>
"""

@app.before_request
def protect():
    username = os.environ.get("APP_USER", "")
    password = os.environ.get("APP_PASSWORD", "")
    auth = request.authorization

    if not username or not password:
        return "Website login is not configured.", 503

    if not auth or auth.username != username or auth.password != password:
        return Response(
            "Login required",
            401,
            {"WWW-Authenticate": 'Basic realm="Canteen SQL"'}
        )

@app.route("/", methods=["GET", "POST"])
def home():
    sql = ""
    columns = []
    rows = []
    message = ""
    error = ""

    if request.method == "POST":
        sql = request.form.get("sql", "").strip()
        first_word = sql.split(maxsplit=1)[0].upper() if sql else ""

        if ";" in sql.rstrip(";"):
            error = "Enter one SQL statement at a time."
        elif first_word not in ("SELECT", "SHOW", "DESCRIBE", "DESC", "EXPLAIN"):
            error = "Only read-only SQL commands are allowed."
        else:
            con = None
            try:
                con = mysql.connector.connect(
                    host=os.environ["DB_HOST"],
                    port=int(os.environ.get("DB_PORT", "3306")),
                    user=os.environ["DB_USER"],
                    password=os.environ["DB_PASSWORD"],
                    database=os.environ.get("DB_NAME", "defaultdb"),
                    ssl_disabled=False,
                    connection_timeout=10
                )

                cur = con.cursor()
                cur.execute(sql)

                if cur.description:
                    columns = [item[0] for item in cur.description]
                    rows = cur.fetchmany(200)
                    message = "Showing up to 200 rows."
                else:
                    message = "Query completed."

                cur.close()

            except Exception:
                error = "Query failed. Check the SQL command and database connection."
            finally:
                if con is not None and con.is_connected():
                    con.close()

    return render_template_string(
        PAGE,
        sql=sql,
        columns=columns,
        rows=rows,
        message=message,
        error=error
    )

if __name__ == "__main__":
    app.run(
        host="0.0.0.0",
        port=int(os.environ.get("PORT", 10000))
    )
