unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeEngine, Series, ExtCtrls, TeeProcs, Chart, StdCtrls, CPort, StrUtils, math,
  ComCtrls, TeeTools, TeeSurfa, TeeSelectorTool, TeeMagnifyTool;

type
  arraysaya = array [-10..10000] of extended;
  array2D = array [0..5000, 0..5000] of extended;
  TForm1 = class(TForm)
    ComPort1: TComPort;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Chart1: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    GroupBox2: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    GroupBox3: TGroupBox;
    Label2: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    GroupBox4: TGroupBox;
    Edit5: TEdit;
    Edit6: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button12: TButton;
    Button13: TButton;
    GroupBox5: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    Chart2: TChart;
    Series3: TLineSeries;
    Series4: TLineSeries;
    Series5: TLineSeries;
    Series6: TLineSeries;
    Chart3: TChart;
    Series7: TLineSeries;
    Series8: TLineSeries;
    Series9: TLineSeries;
    Series10: TLineSeries;
    Button5: TButton;
    Button4: TButton;
    Button9: TButton;
    Button11: TButton;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    Button15: TButton;
    Chart6: TChart;
    Series17: TLineSeries;
    Series18: TLineSeries;
    Button14: TButton;
    Chart4: TChart;
    Series11: TLineSeries;
    Series12: TLineSeries;
    Chart5: TChart;
    Series13: TLineSeries;
    Series14: TLineSeries;
    Series15: TLineSeries;
    Series16: TLineSeries;
    Button16: TButton;
    Chart7: TChart;
    Series19: TSurfaceSeries;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    GroupBox6: TGroupBox;
    Edit8: TEdit;
    Edit7: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    Series20: TLineSeries;
    Button10: TButton;
    Button17: TButton;
    GroupBox7: TGroupBox;
    Label13: TLabel;
    procedure ComPort1RxChar(Sender: TObject; Count: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    function ExtractNumberInString ( sChaine: String ): String ;
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Fourier(sinyal1 : arraysaya; sinyal2 : arraysaya; panjang : integer);
    procedure FourierSTFT(sinyal : arraysaya; panjang : integer);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  buffer : string;
  I, J, K, L, N, hitung, x, thresc3, thresc4, range, geser, nwindow : integer;
  filename : TextFile;
  buffer1, buffer2 : string;
  T, refc3, refc4, av_erdersc3, av_erdersc4, w2, erdersc3, erdersc4, maxc3, maxc4 : extended;
  sinyal1, sinyal2, dft1, dft2, imaginer1, real1, imaginer2, real2, data1, data2,
  lpfc3, lpfc4, hpfc3, hpfc4, notchc3, notchc4, squarec3, squarec4 : arraysaya;
  movavc3, movavc4, window, jalan, jalan2, timepar, frekpar, real, imaginer, dft : arraysaya;
  stft : array2D;
  c3, c4 : array [-10..10000] of double;

const
  fs = 200;
  cb_high : array[0..3] of Extended = (0.777246521400201, -2.33173956420060, 2.33173956420060, -0.777246521400201);
  db_high : array[1..3] of Extended = (2.49860834469118, -2.11525412700316, 0.604109699507275);

  cb_low : array[0..3] of Extended = (0.0047505236109809, 0.01425157083294, 0.01425157083294, 0.004750523610981);
  db_low : array[1..3] of Extended = (2.25008508172639, -1.75640138178595, 0.468312111171712);

implementation

{$R *.dfm}

procedure TForm1.ComPort1RxChar(Sender: TObject; Count: Integer);
begin
  if radiobutton1.Checked = true then
  begin
    if (i<1000) then
    begin
      label2.Caption  := 'REST';
      label2.Font.Color := clRed;
    end
    else if (i>1000) and (i<2000) then
    begin
      Label2.Caption  := 'DORSIFLEXION';
      label2.Font.Color := clGreen;
    end
    else if (i > 2000) then
    begin
      Label2.Caption  := 'REST';
      label2.Font.Color := clRed;
    end;
  end
  else if radiobutton2.Checked = true then
  begin
    if (i<1000) then
    begin
      label2.Caption  := 'REST';
      label2.Font.Color := clRed;
    end
    else if (i>1000) and (i<2000) then
    begin
      Label2.Caption  := 'PLANTARFLEXION';
      label2.Font.Color := clGreen;
    end
    else if (i > 2000) then
    begin
      Label2.Caption  := 'REST';
      label2.Font.Color := clRed;
    end;
  end;

  comport1.ReadStr(buffer, count);

  edit1.Text := LeftStr(buffer, 4);
  edit2.Text := RightStr(buffer, 4);

  buffer1 := ExtractNumberInString(edit1.Text);
  buffer2 := ExtractNumberInString(edit2.Text);

  sinyal1[i] := (strtofloat(buffer1)/4095*3.3)-2;
  sinyal2[i] := (strtofloat(buffer2)/4095*3.3)-2;

  //series1.addxy(i/fs, sinyal1[i]);
  //series2.addxy(i/fs, sinyal2[i]);

  //LPF//
  lpfc3[i] := cb_low[0]*sinyal1[i] + cb_low[1]*sinyal1[i-1] + cb_low[2]*sinyal1[i-2] + cb_low[3]*sinyal1[i-3] + db_low[1]*lpfc3[i-1] + db_low[2]*lpfc3[i-2] + db_low[3]*lpfc3[i-3];
  lpfc4[i] := cb_low[0]*sinyal2[i] + cb_low[1]*sinyal2[i-1] + cb_low[2]*sinyal2[i-2] + cb_low[3]*sinyal2[i-3] + db_low[1]*lpfc4[i-1] + db_low[2]*lpfc4[i-2] + db_low[3]*lpfc4[i-3];

  //HPF
  hpfc3[i] := cb_high[0]*lpfc3[i] + cb_high[1]*lpfc3[i-1] + cb_high[2]*lpfc3[i-2] + cb_high[3]*lpfc3[i-3] + db_high[1]*hpfc3[i-1] + db_high[2]*hpfc3[i-2] + db_high[3]*hpfc3[i-3];
  hpfc4[i] := cb_high[0]*lpfc4[i] + cb_high[1]*lpfc4[i-1] + cb_high[2]*lpfc4[i-2] + cb_high[3]*lpfc4[i-3] + db_high[1]*hpfc4[i-1] + db_high[2]*hpfc4[i-2] + db_high[3]*hpfc4[i-3];

  squarec3[i] := sqr(hpfc3[i]);
  squarec4[i] := sqr(hpfc4[i]);

  //movav
  movavc3[i] := 0;
  movavc4[i] := 0;
  for j := 0 to 30 do
  begin
    movavc3[i] := movavc3[i] + squarec3[i-j];
    movavc4[i] := movavc4[i] + squarec4[i-j];
  end;

  if (i <= 800) then
  begin
    refc3 := refc3 + movavc3[i]/800;
    refc4 := refc4 + movavc4[i]/800;
  end
  else if i > 800 then
  begin
    erdersc3 := (movavc3[i] - refc3)/refc3*100;
    erdersc4 := (movavc4[i] - refc4)/refc4*100;

    if (i >= 1000)and (i < 2000) then
    begin
      av_erdersc3 := av_erdersc3 + erdersc3/1000;
      av_erdersc4 := av_erdersc4 + erdersc4/1000;
      Edit5.Text := floattostr(av_erdersc3);
      Edit6.Text := floattostr(av_erdersc4);
    end
  end;

  if (i > 2000) then
  begin
    thresc3 := 0;
    thresc4 := 0;
    //---PLANTAR FLEXION---//
    if (av_erdersc4 > av_erdersc3) and (av_erdersc3 < thresc3) then
    begin
      ComPort1.WriteStr('C');
      label10.Font.Color := clGreen;
      label10.Font.Size := 11;
      label10.Font.Name := 'Clarendon Blk BT';
    end
    //---DORSIFLEXION---//
    else if (av_erdersc3 > av_erdersc4) and (av_erdersc4 < thresc4) then
    begin
      ComPort1.WriteStr('A');
      label9.Font.Color := clGreen;
      label9.Font.Size := 11;
      label9.Font.Name := 'Clarendon Blk BT';
    end;
  end;

  //series1.AddXY(i/fs, sinyal1[i]);
  //series2.AddXY(i/fs, sinyal2[i]);

  if i > 600 then
  begin
    chart1.BottomAxis.Minimum := (i-600)/fs;
    chart1.BottomAxis.Maximum := i/fs;
  end;

  edit3.Text := inttostr(i);
  edit4.Text := floattostr(i/fs);

  N := i;
  i := i + 1;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if button1.Caption = 'Start' then
  begin
    i := 0;
    av_erdersc3 := 0;
    av_erdersc4 := 0;
    Series1.Clear;
    Series2.Clear;

    comport1.Open;
    button1.Caption := 'Stop';
  end
  else if button1.Caption = 'Stop' then
  begin
    comport1.Close;
    button1.Caption := 'Start';
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  comport1.ShowSetupDialog;
end;

function Tform1.ExtractNumberInString ( sChaine: String ): String ;
var
    i: Integer ;
begin
    Result := '' ;
    for i := 1 to length( sChaine ) do
    begin
        if sChaine[ i ] in ['0'..'9'] then
        Result := Result + sChaine[ i ] ;
    end ;
end ;

procedure TForm1.Button3Click(Sender: TObject);
var
  I : integer;
begin
  with SaveDialog1 do
  begin
    Filter     := 'Data File (*.txt)|*.txt';
    DefaultExt := 'txt';
    FileName   := 'Data EEG ...';
    InitialDir := 'D:\ITS Yayas\Semester 9\Software 8\Data EEG';
  end;

  if SaveDialog1.Execute then
  begin
    AssignFile(filename, SaveDialog1.FileName);
    Rewrite(filename);
    for i := 0 to N do
    begin
      write(filename, ' ', i, ' ',sinyal1[i], ' ',sinyal2[i]);
      writeln(filename);
    end;
    Chart1.SaveToBitmapFile('Data EEG.jpg');
    closefile(filename);
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  I, J : integer;
begin
  Fourier(data1, data2, N);
  for i := 0 to N div 2 do
  begin
    Series7.addxy(i*fs/N, dft1[i]);
    Series8.addxy(i*fs/N, dft2[i]);
  end;

  Fourier(hpfc3, hpfc4, N);
  for j := 0 to N div 2 do
  begin
    Series9.addxy(j*fs/N, dft1[j]);
    Series10.addxy(j*fs/N, dft2[j]);
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  I : integer;
begin
  T := 1/fs;
  if opendialog1.Execute then
  begin
    i := 0;
    assignfile(input,opendialog1.FileName);
    reset(input);
    while not EOF (input) do
    begin
      readln(input, hitung, data1[i], data2[i]);
      i := i + 1;
    end;
    closefile(input);
    N := i;
  end;
  for I := 0 to N-1 do
  begin
    Series3.addxy(i/fs, data1[i]);
    Series4.addxy(i/fs, data2[i]);
  end;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
   ComPort1.WriteStr('A');
   //Sleep(3000);
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
   ComPort1.WriteStr('B');
   //Sleep(3000);
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
   ComPort1.WriteStr('C');
   //Sleep(3000);
end;

procedure TForm1.Button9Click(Sender: TObject);
var
  I : integer;
begin
  w2 := 2*pi*1;
  for i := 0 to N-1 do
  begin
    lpfc3[i] := 0.049*data1[i] + 0.148*data1[i-1] + 0.148*data1[i-2] + 0.049*data1[i-3] + 1.162*lpfc3[i-1] - 0.696*lpfc3[i-2] + 0.138*lpfc3[i-3];
    lpfc4[i] := 0.049*data2[i] + 0.148*data2[i-1] + 0.148*data2[i-2] + 0.049*data2[i-3] + 1.162*lpfc4[i-1] - 0.696*lpfc4[i-2] + 0.138*lpfc4[i-3];

    hpfc3[i] := ((8/sqr(T) - 2*sqr(w2))*hpfc3[i-1] - (4/sqr(T) - 2*sqrt(2)*w2/T + sqr(w2))*hpfc3[i-2] + 4/sqr(T)*lpfc3[i] - 8/sqr(T)*lpfc3[i-1] + 4/sqr(T)*lpfc3[i-2])/(4/sqr(T) + 2*sqrt(2)*w2/T + sqr(w2));
    hpfc4[i] := ((8/sqr(T) - 2*sqr(w2))*hpfc4[i-1] - (4/sqr(T) - 2*sqrt(2)*w2/T + sqr(w2))*hpfc4[i-2] + 4/sqr(T)*lpfc4[i] - 8/sqr(T)*lpfc4[i-1] + 4/sqr(T)*lpfc4[i-2])/(4/sqr(T) + 2*sqrt(2)*w2/T + sqr(w2));

    Series5.addxy(i/fs, hpfc3[i]);
    Series6.addxy(i/fs, hpfc4[i]);
  end;
end;

procedure TForm1.Button10Click(Sender: TObject);
var
  I : integer;
begin
  w2 := 2*pi*1;
  for i := 0 to N-1 do
  begin
    lpfc3[i] := 0.049*data1[i] + 0.148*data1[i-1] + 0.148*data1[i-2] + 0.049*data1[i-3] + 1.162*lpfc3[i-1] - 0.696*lpfc3[i-2] + 0.138*lpfc3[i-3];
    lpfc4[i] := 0.049*data2[i] + 0.148*data2[i-1] + 0.148*data2[i-2] + 0.049*data2[i-3] + 1.162*lpfc4[i-1] - 0.696*lpfc4[i-2] + 0.138*lpfc4[i-3];

    hpfc3[i] := ((8/sqr(T) - 2*sqr(w2))*hpfc3[i-1] - (4/sqr(T) - 2*sqrt(2)*w2/T + sqr(w2))*hpfc3[i-2] + 4/sqr(T)*lpfc3[i] - 8/sqr(T)*lpfc3[i-1] + 4/sqr(T)*lpfc3[i-2])/(4/sqr(T) + 2*sqrt(2)*w2/T + sqr(w2));
    hpfc4[i] := ((8/sqr(T) - 2*sqr(w2))*hpfc4[i-1] - (4/sqr(T) - 2*sqrt(2)*w2/T + sqr(w2))*hpfc4[i-2] + 4/sqr(T)*lpfc4[i] - 8/sqr(T)*lpfc4[i-1] + 4/sqr(T)*lpfc4[i-2])/(4/sqr(T) + 2*sqrt(2)*w2/T + sqr(w2));

    c3[i] := hpfc3[i];
    c4[i] := hpfc4[i];
  end;
  
  for i := 0 to N-1 do
  begin
    if i < 200 then
    begin
      hpfc3[i] := 0;
      hpfc4[i] := 0;
    end;

    Series5.addxy(i/fs, hpfc3[i]);
    Series6.addxy(i/fs, hpfc4[i]);
  end;
end;

procedure TForm1.Button11Click(Sender: TObject);
begin
  Series1.Clear;    Series6.Clear;
  Series2.Clear;    Series7.Clear;
  Series3.Clear;    Series8.Clear;
  Series4.Clear;    Series9.Clear;
  Series5.Clear;    Series10.Clear;
end;

procedure TForm1.Button12Click(Sender: TObject);
begin
  application.Terminate;
end;

procedure TForm1.Button14Click(Sender: TObject);
begin
  for i := 0 to N-1 do
  begin
    //Mas Fathan
    //LPF//
    lpfc3[i] := cb_low[0]*data1[i] + cb_low[1]*data1[i-1] + cb_low[2]*data1[i-2] + cb_low[3]*data1[i-3] + db_low[1]*lpfc3[i-1] + db_low[2]*lpfc3[i-2] + db_low[3]*lpfc3[i-3];
    lpfc4[i] := cb_low[0]*data2[i] + cb_low[1]*data2[i-1] + cb_low[2]*data2[i-2] + cb_low[3]*data2[i-3] + db_low[1]*lpfc4[i-1] + db_low[2]*lpfc4[i-2] + db_low[3]*lpfc4[i-3];

    //HPF
    hpfc3[i] := cb_high[0]*lpfc3[i] + cb_high[1]*lpfc3[i-1] + cb_high[2]*lpfc3[i-2] + cb_high[3]*lpfc3[i-3] + db_high[1]*hpfc3[i-1] + db_high[2]*hpfc3[i-2] + db_high[3]*hpfc3[i-3];
    hpfc4[i] := cb_high[0]*lpfc4[i] + cb_high[1]*lpfc4[i-1] + cb_high[2]*lpfc4[i-2] + cb_high[3]*lpfc4[i-3] + db_high[1]*hpfc4[i-1] + db_high[2]*hpfc4[i-2] + db_high[3]*hpfc4[i-3];

    if i < 60 then
    begin
      hpfc3[i] := 0;
      hpfc4[i] := 0;
    end;

    Series11.addxy(i/fs, hpfc3[i]);
    Series12.addxy(i/fs, hpfc4[i]);

    squarec3[i] := sqr(hpfc3[i]);
    squarec4[i] := sqr(hpfc4[i]);

    movavc3[i] := 0;
    movavc4[i] := 0;
    for j := 0 to 30 do
    begin
      movavc3[i] := movavc3[i] + squarec3[i-j];
      movavc4[i] := movavc4[i] + squarec4[i-j];
    end;

    Series13.addxy(i/fs, squarec3[i]);
    Series14.addxy(i/fs, squarec4[i]);
    Series15.addxy(i/fs, movavc3[i]);
    Series16.addxy(i/fs, movavc4[i]);
  end;
end;

procedure TForm1.Fourier(sinyal1 : arraysaya; sinyal2 : arraysaya; panjang : integer);
var
  I, J : integer;
begin
  for I := 0 to panjang div 2 do
  begin
    real1[i] := 0;
    real2[i] := 0;

    imaginer1[i] := 0;
    imaginer2[i] := 0;

    for J := 0 to panjang-1 do
    begin
      real1[i] := real1[i] + sinyal1[j]*cos(2*pi*i*j/panjang);
      real2[i] := real2[i] + sinyal2[j]*cos(2*pi*i*j/panjang);

      imaginer1[i] := imaginer1[i] - sinyal1[j]*sin(2*pi*i*j/panjang);
      imaginer2[i] := imaginer2[i] - sinyal2[j]*sin(2*pi*i*j/panjang);
    end;
    dft1[i] := (sqrt(sqr(real1[i]) + sqr(imaginer1[i])));
    dft2[i] := (sqrt(sqr(real2[i]) + sqr(imaginer2[i])));
  end;
end;

procedure TForm1.FourierSTFT(sinyal : arraysaya; panjang : integer);
var
  I, J : integer;
begin
  for I := 0 to N div 2 do
  begin
    imaginer[i] := 0;
    real[i] := 0;
    for J := 0 to panjang-1 do
    begin
      real[i] := real[i] + sinyal[j]*cos(2*pi*i*j/panjang);
      imaginer[i] := imaginer[i] - sinyal[j]*sin(2*pi*i*j/panjang);
    end;
    dft[i] := (sqrt(sqr(real[i]) + sqr(imaginer[i])))/fs;
    //Series2.addxy(i, dft[i]);
  end;
end;

procedure TForm1.Button16Click(Sender: TObject);
var
  I, J, min, max : integer;
begin
  range := 200;
  geser := 50;
  nwindow := N div fs;

  for I := 0 to nwindow do
  begin
    //geser window
    min := i*((range div 2) + geser) - (range div 2);
    max := min + range;
    if min < 0 then min := 0;
    for J := 0 to N-1 do window[j] := 0;

    for J := min to max do
    begin
      if radiobutton3.Checked = true then
      begin
        window[j] := 0.5 - (0.5*cos(2*pi*(j-i*((range div 2)+geser))/(range)));
        jalan[j] := hpfc3[j]*window[j];
        jalan2[j-min] := jalan[j];
      end
      else if radiobutton4.Checked = true then
      begin
        window[j] := 0.5 - (0.5*cos(2*pi*(j-i*((range div 2)+geser))/(range)));
        jalan[j] := hpfc4[j]*window[j];
        jalan2[j-min] := jalan[j];
      end;
    end;

    fourierSTFT(jalan2, N);

    //Sumbu x
    timepar[i] := i;

    //sumbu y
    for J := 0 to N div 2 do
    begin
      stft[i,j] := dft[j];
    end;
  end;

  //Sumbu z
  for J := 0 to N div 2 do
  begin
    frekpar[j] := j;
  end;

  for I := 0 to nwindow do
   begin
    for J := 0 to N div 4 do
    begin
      series19.AddXYZ(timepar[i], stft[i,j], frekpar[j]*fs/N);
    end;
   end;
end;

procedure TForm1.Button17Click(Sender: TObject);
var
  I, J: integer;
begin
  w2 := 2*pi*1;
  for i := 0 to N-1 do
  begin
    lpfc3[i] := 0.049*data1[i] + 0.148*data1[i-1] + 0.148*data1[i-2] + 0.049*data1[i-3] + 1.162*lpfc3[i-1] - 0.696*lpfc3[i-2] + 0.138*lpfc3[i-3];
    lpfc4[i] := 0.049*data2[i] + 0.148*data2[i-1] + 0.148*data2[i-2] + 0.049*data2[i-3] + 1.162*lpfc4[i-1] - 0.696*lpfc4[i-2] + 0.138*lpfc4[i-3];

    hpfc3[i] := ((8/sqr(T) - 2*sqr(w2))*hpfc3[i-1] - (4/sqr(T) - 2*sqrt(2)*w2/T + sqr(w2))*hpfc3[i-2] + 4/sqr(T)*lpfc3[i] - 8/sqr(T)*lpfc3[i-1] + 4/sqr(T)*lpfc3[i-2])/(4/sqr(T) + 2*sqrt(2)*w2/T + sqr(w2));
    hpfc4[i] := ((8/sqr(T) - 2*sqr(w2))*hpfc4[i-1] - (4/sqr(T) - 2*sqrt(2)*w2/T + sqr(w2))*hpfc4[i-2] + 4/sqr(T)*lpfc4[i] - 8/sqr(T)*lpfc4[i-1] + 4/sqr(T)*lpfc4[i-2])/(4/sqr(T) + 2*sqrt(2)*w2/T + sqr(w2));

    c3[i] := hpfc3[i];
    c4[i] := hpfc4[i];
  end;

  maxc3 := maxvalue(c3);
  maxc4 := maxvalue(c4);
  
  for i := 0 to N-1 do
  begin
    if (hpfc3[i] < -maxc3*0.4) then
    begin
      hpfc3[i] := 0;
    end
    else if (hpfc3[i] > maxc3*0.4) then
    begin
      hpfc3[i] := 0;
    end;

    if (hpfc4[i] < -maxc4*0.4)then
    begin
      hpfc4[i] := 0;
    end
    else if (hpfc4[i] > maxc4*0.4) then
    begin
      hpfc4[i] := 0;
    end;

    Series5.addxy(i/fs, hpfc3[i]);
    Series6.addxy(i/fs, hpfc4[i]);
  end;
end;

procedure TForm1.Button15Click(Sender: TObject);
var
  I : integer;
  reffc3, reffc4 : extended;
begin
  for i := 0 to N-1 do
  begin
    if (i <= 800) then
    begin
      refc3 := refc3 + movavc3[i]/800;
      refc4 := refc4 + movavc4[i]/800;
    end
    else if i > 800 then
    begin
      erdersc3 := (movavc3[i] - refc3)/refc3*100;
      erdersc4 := (movavc4[i] - refc4)/refc4*100;
      if (i >= 1000)and (i < 2000) then
      begin
        av_erdersc3 := av_erdersc3 + erdersc3/1000;
        av_erdersc4 := av_erdersc4 + erdersc4/1000;
        Edit7.Text := floattostr(av_erdersc3);
        Edit8.Text := floattostr(av_erdersc4);
      end;
      series17.addxy(i/fs, erdersc3);
      series18.addxy(i/fs, erdersc4);
      series20.AddXY(i/fs, 0);
    end;

    if (i > 2000) then
    begin
      thresc3 := 0;
      thresc4 := 0;
      //---PLANTAR FLEXION---//
      if (av_erdersc4 > av_erdersc3) and (av_erdersc3 < thresc3) then
      begin
        label13.Visible := true;
        label13.Caption := 'Plantarflexion';
        label13.Font.Color := clGreen;
        label13.Font.Size := 11;
        label13.Font.Name := 'Clarendon Blk BT';
      end
      //---DORSIFLEXION---//
      else if (av_erdersc3 > av_erdersc4) and (av_erdersc4 < thresc4) then
      begin
        label13.Visible := true;
        label13.Caption := 'Dorsiflexion';
        label13.Font.Color := clGreen;
        label13.Font.Size := 11;
        label13.Font.Name := 'Clarendon Blk BT';
      end;
    end;
  end;
end;

end.

