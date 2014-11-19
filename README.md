sinatra-angularjs-restfull
==========================

Simple restfull app, with Sinatra on the backend and angularjs for the fronted.

API Documentation

Resource: Session
Methods:
  - POST /sessions
    Params: {
      username : 'some_username',
      password : 'some_passwork'
    }
    Response:
      - sucess: {
          code: 201,
          data: { token: 'token' }
        }
      - error: {
          code: 400,
          data: { errors: [] }
        }

  - DELETE /sessions/:token
    Params: {
      username : 'some_username',
      password : 'some_passwork'
    }
    Response:
      - sucess: {
          code: 204, //No content.
        }
      - not found: {
          code: 404,
          data: {}
        }
      - unauthorized: {
          code: 401,
          data: { message: 'You dont have permission to delete that session.'}
        }