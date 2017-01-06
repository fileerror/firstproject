unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin, unit1;

type
    indsov1 = record
      kolsov: integer;
      chast: real;
    end;
    indsov= array [1..40] of indsov1;
    drob = array [1..40] of ansistring;
    chast = array [1..40] of real;
  TForm3 = class(TForm)
    SpinEdit1: TSpinEdit;
    Label1: TLabel;
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  idxs: array [1..100] of real;

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
  totalcleanstr(s);
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

procedure TForm3.Button1Click(Sender: TObject);
var i,j,k:integer;
q:yaz;
s:ansistring;
lok: indsov;
L:drob;
n:real;
c:chast;
begin
  s:=form3.Memo1.Text;
  totalcleanstr(s);
  form3.Memo1.Text:=s;
  lok:=analizind(s);
  idea(s);
  c:=svodhub(s);
end;
end.
