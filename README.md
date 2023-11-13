# LUA MICRO FRAMEWORK TO HANDLE HTTP REQUEST<br />



## Getting started<br />

3 types of contents:<br />
    "application/json",<br />
    "application/x-www-form-urlencoded",<br />
    "multipart/form-data"<br />
<br />
All available paths to test:<br />
GET /api/resource/get <br />
GET /api/resource/get/{id}<br />
GET /api/resource/get/{?name&?age}<br />
POST /api/resource/post<br />
PUT /api/resource/put<br />
PATCH /api/resource/patch<br />
DELETE /api/resource/delete<br />
GET /api/resource/test<br />
GET /api/resource/testukas<br />
GET /api/resource/testas<br />
GET /api/resource/te<br />
GET /api/resource/anon<br />


## Response you will get will be in application/json
/api/resource/get
`json
{<br />
    "message": "Index, main controller"<br />
}<br />
{<br />
    "REQUEST_METHOD": "GET"<br />
}<br />
{<br />
    "url": "/resource/get"<br />
}<br />
{<br />
    "name": "nil"<br />
}`<br />
