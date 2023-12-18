from flask import Flask, render_template, request
from cloudinary.uploader import upload
import cloudinary

app = Flask(__name__)

# Configure Cloudinary with your account details
cloudinary.config(
    cloud_name="dwlv4qogn",
    api_key="617883759449822",
    api_secret="b7Y5H4s1xPLJIaMHBr0AxFa9iQc"
)

@app.route('/')
def index():
    return render_template('indexTest.html')

@app.route('/upload', methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        return 'No file part'

    file = request.files['file']

    if file.filename == '':
        return 'No selected file'

    # Upload the file to Cloudinary
    result = upload(file)

    # The result contains information about the uploaded image, including its public URL
    public_url = result['secure_url']
    return f"Image uploaded successfully. Public URL: {public_url}"

if __name__ == '__main__':
    app.run(debug=True)
