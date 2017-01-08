unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin, unit1,inifiles;

type
    indsov1 = record
      kolsov: integer;
      chast: real;
    end;
    slovar1 = record
      key:ansichar;
      count:real;
    end;
    slovar = array [1..40] of slovar1;
    indsov= array [1..40] of indsov1;
    drob = array [1..40] of ansistring;
    chast = array [1..40] of real;
  TForm3 = class(TForm)
    SpinEdit1: TSpinEdit;
    Label1: TLabel;
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  Form3: TForm3;
  idxs: array [1..100] of real;
  ini:tinifile;

implementation

{$R *.dfm}


function ind(s:ansistring):real;
var i,j,k:integer;
    r:double;
    sk:ansistring;
    q:yaz;
    chast: array [0..50] of double;
begin
  r:=0;
  q:=kbinstr(s);
  for I := 0 to q[0].stolb-1 do begin
    chast[i]:=(q[i].kol*(q[i].kol-1))/(length(s)*(length(s)-1));
    r:=r+chast[i];
  end;
  ind:=r;
end;

function analizind(a:ansistring):indsov;
var i,j,k:integer;
    stri: array [0..40] of ansistring;
    s:ansistring;
    l:indsov;
begin
  s:=form3.Memo1.Text;
  totalcleanstr(s);
  k:=length(s);
  stri[0]:=s;
  for I := 1 to form3.SpinEdit1.Value do begin
    s:=s+s[i];
    stri[i]:=copy(s,i+1,k);
    l[i].kolsov:=0;
    for j := 1 to k do begin
      if stri[0][j] = stri[i][j] then inc(l[i].kolsov);
    end;
    l[i].chast:=l[i].kolsov/k;
  end;
  analizind:=l;
end;

function idea(a:ansistring): integer;
var
  s,s1,s2,s3,s4:ansistring;
  i,j,k:integer;
  m1,m2,m3,m4:yaz;
  massstrok: array [1..40] of ansistring;
begin
  s:=form3.Memo1.Text;
  totalcleanstr(s);
  s1:='';
  s2:='';
  s3:='';
  s4:='';
  while length(s)<>0 do begin
    s1:=s1+copy(s,1,1);
    delete(s,1,1);
    s2:=s2+copy(s,1,1);
    delete(s,1,1);
    s3:=s3+copy(s,1,1);
    delete(s,1,1);
    s4:=s4+copy(s,1,1);
    delete(s,1,1);
  end;
  //form1.Memo1.Text:=s3;
  m1:=kbinstr(s1);
  m2:=kbinstr(s2);
  m3:=kbinstr(s3);
  m4:=kbinstr(s4);
end;

function drobilka(a:ansistring;b:integer): drob;
var  i,j,k:integer;
     l:drob;
     s:ansistring;
begin
  s:=a;
  //totalcleanstr(s);
  for I :=1  to b do l[i]:='';
  k:=1;
  repeat
    if k=b+1 then k:=1
    else begin
      l[k]:=l[k]+copy(s,1,1);
      delete(s,1,1);
      inc(k);
    end;
  until s='';
  drobilka:=l;
end;

function hubind(a:drob;b:integer): real;
var i,j,k:integer;
    l:real;
begin
  l:=0;
  for I := 1 to b do begin
    l:=l+ind(a[i]);
  end;
  l:=l/b;
  hubind:=l;
end;

function svodhub(a:ansistring): chast;
var i,j,k:integer;
    l:chast;
    s:ansistring;
begin
  s:=a;
  totalcleanstr(s);
  for I := 1 to form3.SpinEdit1.Value do begin
    l[i]:=hubind(drobilka(s,i),i);
  end;
  svodhub:=l;
end;

function habrkey(a:chast):integer;
var i,j,k:integer;
begin
  k:=0;
  for I := 1 to form3.SpinEdit1.Value do begin
    for j := 1 to form3.SpinEdit1.Value do begin
      if a[i]*1.06>a[j] then inc(k)
      else begin
        k:=0;
        break;
      end;
    end;
    if k=form3.SpinEdit1.Value
    then begin
      break;
    end;

  end;
  habrkey:=i;
end;

function upkeystr(a:ansistring):ansistring;
var i:integer;
    s:ansistring;
begin
  s:=a;
  for I := 1 to length(s) do begin
    s[i]:=upkeys(s[i]);
  end;
  upkeystr:=s;
end;

function allsdvigsENG(a:ansistring):drob;
var i,j,k:integer;
    s,s1:ansistring;
    resord:integer;
    f:drob;
begin
  s:=a;
  s:=upkeystr(s);
  for I := 0 to 25 do begin
    s1:='';
    for j := 1 to length(s) do begin
      resord:=ord(s[j])-i;
      if resord<65 then resord:=resord+26;
      s1:=s1+chr(resord);
    end;
    f[i+1]:=s1;
  end;
  allsdvigsENG:=f;
end;

function chivalENG(a:ansistring):real;
var i,k,actualcount:integer;
    f,expcount:real;
    s:ansistring;
    textcount:yaz;
begin
  s:=a;
  totalcleanstr(s);
  s:=upkeystr(s);
  f:=0.0;
  textcount:=kbinstr(s);
  for I :=65  to 90 do begin
    k:=nom(ansichar(i),textcount);
    if k<>-1 then actualcount:=textcount[k].kol
    else actualcount:=0;
    expcount:=ini.ReadFloat('ENG',ansichar(i),0)*length(s);
    f:=f+(sqr(actualcount-expcount))/expcount;
  end;
  chivalENG:=f;
end;

function decryptkeyENG(a:ansistring;b:integer):ansistring;
var i,j,k,rotnum:integer;
    f,s,strseq,rotstr,curstr:ansistring;
    dr,allrot:drob;
    max,cuci:extended;
begin
  f:='';
  s:=a;
  dr:=drobilka(s,b);
  for I := 1 to b do begin
    strseq:=dr[i];
    allrot:=allsdvigsENG(strseq);
    rotnum:=0;
    rotstr:='';
    max:=1.1e4931;
    for j := 1 to 26 do begin
      curstr:=allrot[j];
      cuci:=chivalENG(curstr);
      if cuci<max then begin
        rotnum:=j;
        rotstr:=curstr;
        max:=cuci;
      end;
    end;
    f:=f+ansichar(rotnum+96);
  end;
  decryptkeyENG:=f;
end;

procedure hack(a:ansistring);
var s:ansistring;
begin
  s:=a;
  form3.Memo1.Lines.Add('*******************************');
  form3.Memo1.Lines.Add('Key:'+decryptkeyENG(s,habrkey(svodhub(s))));
end;

procedure TForm3.Button1Click(Sender: TObject);
var i,j,k:integer;
q:yaz;
s,s1:ansistring;
lok: indsov;
L:drob;
n,p:real;
c:chast;
begin
  s:=form3.Memo1.Text;
  hack(s);
end;
procedure TForm3.Button2Click(Sender: TObject);
var i:integer;
begin
for I := 1 to 300 do form3.Memo1.Text:=form3.Memo1.Text+' '+'['+inttostr(i)+']'+ansichar(i);

end;

procedure TForm3.Button3Click(Sender: TObject);
var s:ansistring;
begin
  s:=form3.Memo1.Text;
  totalcleanstr(s);
  form3.Memo1.Text:=s;
end;

procedure TForm3.FormCreate(Sender: TObject);
var dir:string;
begin
  ini:=tinifile.Create(getcurrentdir+'\LangInfo.ini');
end;

end.
