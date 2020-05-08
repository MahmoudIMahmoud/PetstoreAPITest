import requests

url = "https://petstore.swagger.io/v2/pet/123/uploadImage"

payload = {}
files = [
  ('file', open('./petimage.jpeg','rb'))
]
headers = {
  'Content-Type': 'multipart/form-data'
}

response = requests.request("POST", url, headers=headers, data = payload, files = files)

print(response.text.encode('utf8'))