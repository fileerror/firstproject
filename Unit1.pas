unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.Menus,
  VclTee.TeeGDIPlus, VCLTee.TeEngine, VCLTee.Series, Vcl.ExtCtrls,
  VCLTee.TeeProcs, VCLTee.Chart;

type
  kolvo = record
    sim:ansichar;
    kol:int64;
    stolb:byte;
  end;
  yaz=array [0..100] of kolvo;
  TForm1 = class(TForm)
    Memo1: TMemo;
    StringGrid1: TStringGrid;
    Button1: TButton;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    Chart1: TChart;
    Series1: TBarSeries;
    Button2: TButton;
    N4: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  tab=record
    sim:ansichar;
    kol:int64;
    chast:extended;
  end;
  function nom(a:ansichar;b:yaz):integer;
  function kbinstr(a:ansistring): yaz;
  procedure cleanstr(var a:ansistring);
  procedure totalcleanstr(var a:ansistring);
  function upkeys(a:ansichar):ansichar;
const m: set of ansichar = ['.', ',', '?', '!', ':', ';', ' ', '-', '''', ')', '(',
                        #10, #13, #0, #185, #171, #133, #147, #148, #150, #151,
                        #187, #34];

var
  Form1: TForm1;
  inptxt: array [0..100] of tab ;
  allsim: int64;
  //p:integer;

implementation

{$R *.dfm}

uses Unit2, Unit3;

function znach(a,b:integer):ansichar;
begin
  znach:=ansichar(ord(form1.StringGrid1.Cells[a,b][1]));
end;

procedure totalcleanstr(var a:ansistring);                //TOTALCLEANSTR
var k:integer;
begin
  k:=1;
  repeat
    if a[k] in m
      then delete(a,k,1)
      else inc(k);
  until k>length(a);
end;

procedure cleanstr(var a:ansistring);                //CLEANSTR
var k:integer;
begin
  k:=1;
  repeat
    if (a[k]=' ') or (a[k]=#10) or (a[k]=#13)
      then delete(a,k,1)
      else inc(k);
  until k>length(a);
end;

function upkeys(a:ansichar):ansichar;                //UPKEYS
begin
  if ((ord(a)>=97) and (ord(a)<=122)) or ((ord(a)>=224) and (ord(a)<=255))
    then upkeys:=ansichar(ord(a)-32)
    else upkeys:=a;
end;

procedure qsort(var a:array of tab; min,max:integer);                //QSORT
var i,j:integer;
    supp,tmp:ansichar;
begin
  supp:=a[max-((max-min) div 2)].sim;
  i:=min;
  j:=max;
  while i<j do begin
    while a[i].sim<supp do inc(i);
    while a[j].sim>supp do dec(j);
    if i<=j then begin
      tmp:=a[i].sim;
      a[i].sim:=a[j].sim;
      a[j].sim:=tmp;
      inc(i);
      dec(j);
    end;
  end;
  if min<j then qsort(a,min,j);
  if i<max then qsort(a,i,max);
end;

function nom(a:ansichar; b:yaz):integer;       //NOM
var i:integer;
begin
  nom:=-1;
  for I := 0 to b[0].stolb-1 do if b[i].sim=upkeys(a) then begin
  nom:=i;
  break;
  end;
end;

function kbinstr(a:ansistring): yaz;     //KBINSTR
var i,j,k,q:integer;
    n:set of ansichar;
    w:yaz;
begin
  q:=0;
  n:=[];
  w[0].stolb:=0;
  for I := 1 to length(a) do begin
    if (not (a[i] in m)) and (not(a[i] in n)) then begin
      w[q].sim:=upkeys(a[i]);
      n:=n+[upkeys(a[i]),(ansichar(ord(upkeys(a[i]))+32))];
      w[q].kol:=1;
      inc(q);
      w[0].stolb:=q;
    end else if nom(a[i],w)<>-1 then inc(w[nom(a[i],w)].kol)
  end;
  kbinstr:=w;
  //kbinstr[0].stolb:=q;
end;


procedure TForm1.Button1Click(Sender: TObject);
var
  I,k,j,kol: Int64;
  n:set of ansichar;
  s,s1:ansistring;
  p:byte;
  mass:yaz;
begin
  s:=form1.Memo1.Lines.Text;
  {p:=0;
  n:=[];
  kol:=0;
  for I := 1 to length(s) do begin
    s1:=s1+upkeys(s[i]);
    if (not (s[i] in m)) and (not(s[i] in n)) then begin
      inptxt[p].sim:=upkeys(s[i]);
      n:=n+[upkeys(s[i]),(ansichar(ord(upkeys(s[i]))+32))];
      inptxt[p].kol:=1;
      inc(p);
      inc(allsim);
    end else if nom(s[i])<>-1 then begin
          inc(inptxt[nom(s[i])].kol);
          inc(allsim);
        end;}
  mass:=kbinstr(s);
  totalcleanstr(s);
  p:=mass[0].stolb;
  allsim:=length(s);
  for I := 0 to mass[0].stolb-1 do begin
    inptxt[i].sim:=mass[i].sim;
    inptxt[i].kol:=mass[i].kol;
    inptxt[i].chast:=inptxt[i].kol/allsim;
  end;
  form1.Series1.Clear;
  form1.StringGrid1.ColCount:=p;
  for I := 0 to p-1 do begin
    form1.StringGrid1.Cells[i,0]:=inptxt[i].sim;
    form1.StringGrid1.Cells[i,1]:=inttostr(inptxt[i].kol);
    form1.StringGrid1.Cells[i,2]:=floattostrf(inptxt[i].chast,ffFixed,10,3) ;
    form1.Series1.Add(inptxt[i].chast,inptxt[i].sim,clgreen);
  end;
  //qsort(inptxt,0,p-1);
  showmessage(inttostr(allsim));
  //cleanstr(s);
end;



procedure TForm1.Button2Click(Sender: TObject);
begin
  form1.Memo1.Clear;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  form1.StringGrid1.ColCount:=17000;
end;

procedure TForm1.N1Click(Sender: TObject);
begin
  form1.Show;
end;

procedure TForm1.N2Click(Sender: TObject);
begin
  form1.Hide;
  form2.show;
end;

procedure TForm1.N3Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.N4Click(Sender: TObject);
begin
 form3.show;
end;

end.
