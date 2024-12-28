using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO.Ports;
using ZedGraph;

namespace WindowsFormsApp
{
    public partial class display : Form
    {
        public display()
        {
            InitializeComponent();
        }

        
        string[] baud = {"1200", "2400", "4800", "9600", "19200","38400","57600", "14880"};
        private void display_Load(object sender, EventArgs e)
        {
            string[] listnamecom = SerialPort.GetPortNames();
            listcom.Items.AddRange(listnamecom);
            listbaud.Items.AddRange(baud);

            GraphPane myPanne = zedGraphControl1.GraphPane;
            myPanne.Title.Text = "Giá trị nhiệt độ";
            myPanne.YAxis.Title.Text = "Nhiệt độ";
            myPanne.XAxis.Title.Text = "Thời gian";

            RollingPointPairList list = new RollingPointPairList(500000);

            LineItem line = myPanne.AddCurve("nhiệt độ", list, Color.Red, SymbolType.Circle);

            myPanne.XAxis.Scale.Min = 0;
            myPanne.XAxis.Scale.Max = 100;
            myPanne.XAxis.Scale.MinorStep = 1;
            myPanne.XAxis.Scale.MajorStep = 2;

            myPanne.YAxis.Scale.Min = 0;
            myPanne.YAxis.Scale.Max = 50;
            myPanne.YAxis.Scale.MinorStep = 1;
            myPanne.YAxis.Scale.MajorStep = 2;

            zedGraphControl1.AxisChange();
        }
        int tong = 0;
        public void draw(double line)
        {
            LineItem duong_ke = zedGraphControl1.GraphPane.CurveList[0] as LineItem;
            if (duong_ke == null)
            {
                return;
            }
            IPointListEdit list = duong_ke.Points as IPointListEdit;
            if (list == null)
            {
                return;
            }

            list.Add(tong, line);           
            zedGraphControl1.AxisChange();
            zedGraphControl1.Invalidate();
            tong += 2;
        }



        private void connect_Click(object sender, EventArgs e)
        {
            try
            {
                if (listcom.Text == "")
                {
                    MessageBox.Show("Hãy chọn cổng COM", "Thông báo");
                }
                if (listbaud.Text == "")
                {
                    MessageBox.Show("Hãy chọn Baudrate", "Thông báo");
                }
                if (serialPort1.IsOpen == true)
                {
                    serialPort1.Close();
                    connect.Text = "Connect";
                }
                else
                {
                    serialPort1.PortName = listcom.Text;
                    serialPort1.BaudRate = int.Parse(listbaud.Text);
                    serialPort1.Open();
                    connect.Text = "Disconnect";
                }
            }
            catch 
            {
                MessageBox.Show("Error","Notification");    
            }
        }



        bool light1 = true;
        private void led1_Click(object sender, EventArgs e)
        {
            try
            {
                if (light1 == true)
                {
                    serialPort1.WriteLine("led1 on");
                    led1.Text = "Led1 off";
                    light1 = false;
                }
                else
                {
                    serialPort1.WriteLine("led1 off");
                    led1.Text = "Led1 on";
                    light1 = true;
                }
            }
            catch
            {
                MessageBox.Show("Error");
            }
        }

        bool light5 = true;
        private void button4_Click(object sender, EventArgs e)
        {
            try
            {
                if (light5 == true)
                {
                    serialPort1.WriteLine("led5 on");
                    button4.Text = "Led5 off";
                    light5 = false;
                }
                else
                {
                    serialPort1.WriteLine("led5 off");
                    button4.Text = "Led5 on";
                    light5 = true;
                }
            }
            catch
            {
                MessageBox.Show("Error");
            }
        }

        bool light2 = true;
        private void led2_Click(object sender, EventArgs e)
        {
            try
            {
                if (light2 == true)
                {
                    serialPort1.WriteLine("led2 on");
                    led2.Text = "Led2 off";
                    light2 = false;
                }
                else
                {
                    serialPort1.WriteLine("led2 off");
                    led2.Text = "Led2 on";
                    light2 = true;
                }
            }
            catch
            {
                MessageBox.Show("Error");
            }
        }

        bool light3 = true;
        private void led3_Click(object sender, EventArgs e)
        {
            try
            {
                if (light3 == true)
                {
                    serialPort1.WriteLine("led3 on");
                    led3.Text = "Led3 off";
                    light3 = false;
                }
                else
                {
                    serialPort1.WriteLine("led3 off");
                    led3.Text = "Led3 on";
                    light3 = true;
                }
            }
            catch
            {
                MessageBox.Show("Error");
            }
        }

        bool light4 = true;
        private void led4_Click(object sender, EventArgs e)
        {
            try
            {
                if (light4 == true)
                {
                    serialPort1.WriteLine("led4 on");
                    led4.Text = "Led4 off";
                    light4 = false;
                }
                else
                {
                    serialPort1.WriteLine("led4 off");
                    led4.Text = "Led4 on";
                    light4 = true;
                }
            }
            catch
            {
                MessageBox.Show("Error");
            }
        }

        bool light6 = true;
        private void led6_Click(object sender, EventArgs e)
        {
            try
            {
                if (light6 == true)
                {
                    serialPort1.WriteLine("led6 on");
                    led6.Text = "Led6 off";
                    light6 = false;
                }
                else
                {
                    serialPort1.WriteLine("led6 off");
                    led6.Text = "Led6 on";
                    light6 = true;
                }
            }
            catch
            {
                MessageBox.Show("Error");
            }
        }
        
        bool light7 = true;
        private void led7_Click(object sender, EventArgs e)
        {
            try
            {
                if (light7 == true)
                {
                    serialPort1.WriteLine("led7 on");
                    led7.Text = "Led7 off";
                    light7 = false;
                }
                else
                {
                    serialPort1.WriteLine("led7 off");
                    led7.Text = "Led7 on";
                    light7 = true;
                }
            }
            catch
            {
                MessageBox.Show("Error");
            }
        }

        bool light8 = true;
        private void led8_Click(object sender, EventArgs e)
        {
            try
            {
                if (light8 == true)
                {
                    serialPort1.WriteLine("led8 on");
                    led8.Text = "Led8 off";
                    light8 = false;
                }
                else
                {
                    serialPort1.WriteLine("led8 off");
                    led8.Text = "Led8 on";
                    light8 = true;
                }
            }
            catch
            {
                MessageBox.Show("Error");
            }
        }


        private void send_lighttime_Click(object sender, EventArgs e)
        {
            if (lighttime.Text.Length > 0)
            {
                serialPort1.Write(lighttime.Text);
                serialPort1.Write("\r\n");
            }
        }


        private readonly object lockObject = new object();
        string string_total;
        string bo_dem;
        string nhiet_do;
        int i = 0;
        private void serialPort1_DataReceived(object sender, SerialDataReceivedEventArgs e)
        {
            string datareceived = serialPort1.ReadLine();

            string_total = datareceived;
            
            string_total = string_total.Trim();
            if(string_total.Length > 2)               
            {
               Invoke(new MethodInvoker(() =>
               {
                    i++;
                    bo_dem = i.ToString("D3");
                    textBox1.Text = bo_dem;
                    string_total = datareceived = "";
               }));
            }
 
           
            if (string_total.Length == 2)
            {
                nhiet_do = datareceived;
                Invoke(new MethodInvoker(() =>
                {
                   draw(double.Parse(nhiet_do));
                }));
                Invoke(new MethodInvoker(() =>
                {
                    textBox2.Text = nhiet_do;
                }));
            }
        }
    }
}
