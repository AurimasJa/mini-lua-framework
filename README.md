# LUA MICRO FRAMEWORK TO HANDLE HTTP REQUEST



## Getting started

3 types of contents:
    "application/json",
    "application/x-www-form-urlencoded",
    "multipart/form-data"

All available paths to test:
GET /api/resource/get
GET /api/resource/get/{id}
GET /api/resource/get/{?name&?age}
POST /api/resource/post
PUT /api/resource/put
PATCH /api/resource/patch
DELETE /api/resource/delete
GET /api/resource/test
GET /api/resource/testukas
GET /api/resource/testas
GET /api/resource/te
GET /api/resource/anon


## Response you will get will be in application/json
/api/resource/get
`json
{
    "message": "Index, main controller"
}
{
    "REQUEST_METHOD": "GET"
}
{
    "url": "/resource/get"
}
{
    "name": "nil"
}`
