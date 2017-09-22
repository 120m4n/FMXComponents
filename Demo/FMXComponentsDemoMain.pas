unit FMXComponentsDemoMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, FMX.Types, FMX.Controls, FMX.Forms,
  FMX.Objects, FMX.Layouts,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.ScrollableList, FMX.RatingBar,
  FMX.Ani, FMX.CircleScoreIndicator, FMX.TabControl, FMX.ImageSlider,
  FMX.ScrollBox, FMX.Memo, FMX.SimpleBBCodeText, ONE.Objects, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, FMX.GesturePassword, FMX.CalendarControl,
  qcndate, CnCalendar, FMX.Seg7Shape;

type
  TFMXComponentsDemoForm = class(TForm)
    Layout16: TLayout;
    Layout3: TLayout;
    Line1: TLine;
    Line4: TLine;
    FMXScrollableList2: TFMXScrollableList;
    Label1: TLabel;
    LayoutYears: TLayout;
    Layout2: TLayout;
    Line2: TLine;
    Line3: TLine;
    FMXScrollableList1: TFMXScrollableList;
    Label2: TLabel;
    FMXRatingBar1: TFMXRatingBar;
    lblHeader: TLabel;
    btnAnimation: TButton;
    FloatAnimation1: TFloatAnimation;
    FMXCircleScoreIndicator1: TFMXCircleScoreIndicator;
    FloatAnimation2: TFloatAnimation;
    Layout4: TLayout;
    Layout5: TLayout;
    Line5: TLine;
    Line6: TLine;
    FMXScrollableList3: TFMXScrollableList;
    Label3: TLabel;
    TabControl1: TTabControl;
    tabBasic: TTabItem;
    tabSlider: TTabItem;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    FMXImageSlider1: TFMXImageSlider;
    FloatAnimation3: TFloatAnimation;
    tabBBCode: TTabItem;
    Memo1: TMemo;
    Layout1: TLayout;
    FMXSimpleBBCodeText1: TFMXSimpleBBCodeText;
    tabGesturePassword: TTabItem;
    Layout6: TLayout;
    FMXGesturePassword1: TFMXGesturePassword;
    lbl1: TLabel;
    lblPassword: TLabel;
    tabCalendarControl: TTabItem;
    FMXCalendarControl1: TFMXCalendarControl;
    Layout7: TLayout;
    chkShowLunarDate: TCheckBox;
    rbCnMonths: TRadioButton;
    rbEnMonths: TRadioButton;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    txtCnDate1: TText;
    txtCnDate2: TText;
    tabSeg7Shape: TTabItem;
    Button1: TButton;
    tmr1: TTimer;
    Seg7Shape1: TFMXSeg7Shape;
    Seg7Shape2: TFMXSeg7Shape;
    FMXRatingBar2: TFMXRatingBar;
    FloatAnimation4: TFloatAnimation;
    txtScore: TLabel;
    procedure FMXScrollableList2Change(Sender: TObject);
    procedure FMXScrollableList1Change(Sender: TObject);
    procedure btnAnimationClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FMXScrollableList3Change(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FMXSimpleBBCodeText1Click(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure FMXGesturePassword1EnterCompleteEvent(Sender: TObject;
      const APassword: string);
    procedure chkShowLunarDateChange(Sender: TObject);
    procedure rbCnMonthsChange(Sender: TObject);
    procedure FMXCalendarControl1SelectedItem(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure FloatAnimation2Process(Sender: TObject);
  private
    { Private declarations }
    FSelection1: TOneSelection;
    ShuffleCount : Byte;
    procedure RollSegment(Sender: TObject ; Data : Byte );
    procedure RollSegmentSet( Count : Byte);
  public
    { Public declarations }
  end;

var
  FMXComponentsDemoForm: TFMXComponentsDemoForm;

implementation

{$R *.fmx}

procedure TFMXComponentsDemoForm.btnAnimationClick(Sender: TObject);
begin
  FloatAnimation1.Start;
  FloatAnimation2.Start;
  FloatAnimation4.Start;
end;

procedure TFMXComponentsDemoForm.Button1Click(Sender: TObject);
begin
  tmr1.Enabled  := TRUE;
  Button1.Enabled := False;
  ShuffleCount     := 17;
  Seg7Shape1.Num  := $ff;
  Seg7Shape2.Num  := $ff;
  Randomize;
  Seg7Shape1.Fill.Color := Seg7Shape1.Fill.Color + Random($ffffffff);
  Seg7Shape2.Fill.Color := Seg7Shape1.Fill.Color + Random($ffffffff);
  RollSegmentSet( ShuffleCount );
end;

procedure TFMXComponentsDemoForm.chkShowLunarDateChange(Sender: TObject);
begin
  FMXCalendarControl1.IsShowLunarDate := chkShowLunarDate.IsChecked;
end;

procedure TFMXComponentsDemoForm.FloatAnimation2Process(Sender: TObject);
begin
  txtScore.Text := IntToStr(Round(FMXCircleScoreIndicator1.Value));
end;

procedure TFMXComponentsDemoForm.FMXCalendarControl1SelectedItem(
  Sender: TObject);
var
  D: TCnDate;
  Year, Month, Day: Word;
begin
  DecodeDate(FMXCalendarControl1.SelectedDate, Year, Month, Day);
  D := ToCnDate(FMXCalendarControl1.SelectedDate);
  txtCnDate1.Text := Format('ũ��%s%s', [CnMonthName(D), CnDayName(D)]);
  txtCnDate2.Text :=
    GetGanZhiFromNumber(GetGanZhiFromYear(Year)) +
    GetShengXiaoFromNumber(D.Year) + '�� ' +
    GetGanZhiFromNumber(GetGanZhiFromMonth(Year, Month, Day)) + '�� ' +
    GetGanZhiFromNumber(GetGanZhiFromDay(Year, Month, Day)) + '��';
end;

procedure TFMXComponentsDemoForm.FMXGesturePassword1EnterCompleteEvent(
  Sender: TObject; const APassword: string);
begin
  lblPassword.Text := self.FMXGesturePassword1.Password;
end;

procedure TFMXComponentsDemoForm.FMXScrollableList1Change(Sender: TObject);
begin
  Label1.Text := FMXScrollableList1.GetSelected;
end;

procedure TFMXComponentsDemoForm.FMXScrollableList2Change(Sender: TObject);
begin
  Label2.Text := FMXScrollableList2.GetSelected;
end;

procedure TFMXComponentsDemoForm.FMXScrollableList3Change(Sender: TObject);
begin
  Label3.Text := FMXScrollableList3.GetSelected;
end;

procedure TFMXComponentsDemoForm.FMXSimpleBBCodeText1Click(Sender: TObject);
var
  c: TControl;
begin
  if FSelection1.ChildrenCount > 0 then
  begin
    c := TControl(FSelection1.Children[0]);
    c.HitTest := True;
    c.Align := TAlignLayout.None;
    c.Parent := Layout1;
    c.BoundsRect := FSelection1.BoundsRect;
    c.Position.Point := FSelection1.Position.Point;
  end;

  FSelection1.BoundsRect := TControl(Sender).BoundsRect;
  FSelection1.Position.Point := TControl(Sender).Position.Point;
  FSelection1.Visible := True;
  FSelection1.BringToFront;

  TControl(Sender).Parent := FSelection1;
  TControl(Sender).Align := TAlignLayout.Client;
  TControl(Sender).HitTest := False;
end;

procedure TFMXComponentsDemoForm.FormCreate(Sender: TObject);
begin
  Label1.Text := FMXScrollableList1.GetSelected;
  Label2.Text := FMXScrollableList2.GetSelected;
  Label3.Text := FMXScrollableList3.GetSelected;

  FMXImageSlider1.SetPage(0, Image1);
  FMXImageSlider1.SetPage(1, Image2);
  FMXImageSlider1.SetPage(2, Image3);
  FMXImageSlider1.SetPage(3, Image4);

  FSelection1 := TOneSelection.Create(Self);
  FSelection1.GripSize := 8;
  FSelection1.Proportional := False;
  Layout1.AddObject(FSelection1);

  FMXSimpleBBCodeText1Click(FMXSimpleBBCodeText1);

  txtCnDate1.Text := '';
  txtCnDate2.Text := '';
end;

procedure TFMXComponentsDemoForm.FormResize(Sender: TObject);
begin
  FMXImageSlider1.Height := ClientWidth * 200 / 320;
end;

procedure TFMXComponentsDemoForm.Memo1Change(Sender: TObject);
begin
  self.FMXSimpleBBCodeText1.Lines.Assign(Memo1.Lines);
end;

procedure TFMXComponentsDemoForm.rbCnMonthsChange(Sender: TObject);
begin
  if (Sender as TControl).Tag = 0 then
    Self.FMXCalendarControl1.SetMonthNames(TCnMonths)
  else
    Self.FMXCalendarControl1.SetMonthNames(TEnMonths);
end;

procedure TFMXComponentsDemoForm.RollSegment(Sender: TObject; Data: Byte);
begin
  (Sender as TFMXSeg7Shape).Data := Data;
end;

procedure TFMXComponentsDemoForm.RollSegmentSet(Count: Byte);
begin
  case Count of
     17,9,1 : begin  RollSegment(Seg7Shape1 , $01 );  RollSegment(Seg7Shape2 , $01 ); end;
     16,8 : begin  RollSegment(Seg7Shape1 , $00 );  RollSegment(Seg7Shape2 , $03 ); end;
     15,7 : begin  RollSegment(Seg7Shape1 , $00 );  RollSegment(Seg7Shape2 , $06 ); end;
     14,6 : begin  RollSegment(Seg7Shape1 , $00 );  RollSegment(Seg7Shape2 , $0C ); end;
     13,5 : begin  RollSegment(Seg7Shape1 , $08 );  RollSegment(Seg7Shape2 , $08 ); end;
     12,4 : begin  RollSegment(Seg7Shape1 , $18 );  RollSegment(Seg7Shape2 , $00 ); end;
     11,3 : begin  RollSegment(Seg7Shape1 , $30 );  RollSegment(Seg7Shape2 , $00 ); end;
     10,2 : begin  RollSegment(Seg7Shape1 , $21 );  RollSegment(Seg7Shape2 , $00 ); end;
  end;

end;

procedure TFMXComponentsDemoForm.tmr1Timer(Sender: TObject);
var
    RandData: Byte;
begin
  if (ShuffleCount = 0) then
  begin
    RandData := Random(100);
    Seg7Shape1.Num := RandData mod 10;
    Seg7Shape2.Num := RandData div 10;
    tmr1.Enabled := False;
    Button1.Enabled := TRUE;
    Seg7Shape1.Fill.Color := TAlphaColorRec.Blue;
    Seg7Shape2.Fill.Color := TAlphaColorRec.Blue;
  end
  else
  begin
    Seg7Shape1.Fill.Color := Seg7Shape1.Fill.Color + Random($FFFFFFFF);
    Seg7Shape2.Fill.Color := Seg7Shape1.Fill.Color + Random($FFFFFFFF);
    Dec(ShuffleCount);
    RollSegmentSet(ShuffleCount);
  end;
end;

end.
