
from flask import Flask, request, render_template_string
import sqlite3

app = Flask(__name__)
DB = "canteen.db"

PAGE = """
<h1>Canteen Smart Token System</h1>
<p>Enter a SQL command below:</p>
<form method="post">
<textarea name="sql" rows="8" cols="80" required>{{ sql }}</textarea><br><br>
<button type="submit">Execute SQL</button>
</form>
{% if error %}<p style="color:red">{{ error }}</p>{% endif %}
{% if columns %}
<table border="1" cellpadding="8">
<tr>{% for c in columns %}<th>{{ c }}</th>{% endfor %}</tr>
{% for row in rows %}
<tr>{% for value in row %}<td>{{ value }}</td>{% endfor %}</tr>
{% endfor %}
</table>
{% elif message %}<p>{{ message }}</p>{% endif %}
"""

@app.route("/", methods=["GET", "POST"])
def home():
    sql = ""
    columns = []
    rows = []
    message = ""
    error = ""
    if request.method == "POST":
        sql = request.form.get("sql", "").strip()
        try:
            with sqlite3.connect(DB) as con:
                cur = con.cursor()
                cur.execute(sql)
                if cur.description:
                    columns = [item[0] for item in cur.description]
                    rows = cur.fetchall()
                else:
                    message = f"Command executed. Rows affected: {cur.rowcount}"
        except Exception as e:
            error = str(e)
    return render_template_string(PAGE, sql=sql, columns=columns, rows=rows, message=message, error=error)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=10000)
