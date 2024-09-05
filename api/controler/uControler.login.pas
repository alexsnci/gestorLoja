unit uControler.login;

interface
  uses uInterface.login,uLogin.model,horse;

  procedure Start;

implementation
  procedure onGetLogin(aReq : THorseRequest; aRes : ThorseResponse);
  begin
      var
        login : iLogin;
        login := TLoginModel.New;

        aRes.Send(login.get(aReq.Query.Field('user').AsString, aReq.Query.Field('password').AsString));
  end;

  procedure onPostLogin(aReq : THorseRequest; aRes : ThorseResponse);
  begin
      var
        login : iLogin;
        login := TLoginModel.New;

        aRes.Send(login.post(aReq.Body));
  end;
  procedure Start;
  begin
    Thorse.Get('Login',onGetLogin);
    Thorse.Post('Login',onGetLogin);
  end;
end.
