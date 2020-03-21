import requests

def upload_image(_url,file_path):
    url = _url
    files = {'file': open(file_path, 'rb'),'type':'image/jpeg'}
    headers = {
        'accept': 'application/json',
        'Content-Type': 'multipart/form-data'
    }
    response = requests.request("POST", url, files=files, headers=headers)
    
    return response