B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=9.801
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region

Sub Process_Globals
	Private bmppointer As Bitmap
	Dim reply As String
	Dim test As Boolean
End Sub

Sub Globals

	Private cvsGraph As Canvas	', cvsGraph2
	Private pnl1 As Panel		', pnl2
	Private img1 As ImageView
	Private rect1 As Rect
	Private Button1 As Button
	Private Button2 As Button
	Private text1 As EditText
	Private Label1 As Label
	Dim bc As ByteConverter
End Sub

Sub Activity_Create(FirstTime As Boolean)
	If FirstTime Then
		bmppointer.Initialize(File.DirAssets,"point2.png")
	End If

	Activity.LoadLayout("layout1")
	
	cvsGraph.Initialize(pnl1)	' initialize the Canvas for the panel
	pnl1.Left=50%x-200
	img1.Left=50%x-200
	rect1.Initialize(65, 65, 320dip, 320dip)
	cvsGraph.DrawBitmap(bmppointer, Null, rect1)
	pnl1.Invalidate

End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Public Sub UpdateState
	Button1.Enabled = Starter.Manager.ConnectionState
	Button2.Enabled = Starter.Manager.ConnectionState
End Sub

	
Sub Button2_Click
	Dim i=1 As Int
	
	test=False
	Do While i=1
		Starter.Manager.SendMessage("010C" & Chr(13) & Chr(10))
		reply=""
		Sleep(500)
		If test Then Exit
	Loop
End Sub



Sub Button1_Click
	test=True
	Starter.Manager.SendMessage("ATZ" & Chr(13) & Chr(10))
	reply=""
End Sub

Public Sub NewMessage (msg As String)
	reply = reply & msg
	If reply.Contains(">") Then
		text1.Text = reply
		If reply.Length > 18 Then rpm
	End If

End Sub

Sub rpm
	Dim a, b As Int
	Dim angle As Float
	Dim rpmD As String
	Dim aa(), bb() As Byte
	
	aa=bc.HexToBytes(reply.SubString2(13,15))
	bb=bc.HexToBytes(reply.SubString2(16,18))
	a=Bit.And(0xFF,aa(0))		'convert byte to unsigned byte
	b=Bit.And(0xFF,bb(0))
	'Log(aa(0) & " 1")

	angle = ((a * 256 + b) / 100) - 120
	rpmD = (a * 256 + b) / 4
	Label1.Text=rpmD
	reply = ""
	
	cvsGraph.DrawRect(rect1, Colors.Transparent, True, 3dip)		'refresh screen
	cvsGraph.DrawBitmapRotated(bmppointer, Null, rect1, angle)
	pnl1.Invalidate
	
End Sub
