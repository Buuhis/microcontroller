namespace WindowsFormsApp
{
    partial class display
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.connect = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.listcom = new System.Windows.Forms.ComboBox();
            this.listbaud = new System.Windows.Forms.ComboBox();
            this.label2 = new System.Windows.Forms.Label();
            this.serialPort1 = new System.IO.Ports.SerialPort(this.components);
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.zedGraphControl1 = new ZedGraph.ZedGraphControl();
            this.led1 = new System.Windows.Forms.Button();
            this.led2 = new System.Windows.Forms.Button();
            this.led3 = new System.Windows.Forms.Button();
            this.led4 = new System.Windows.Forms.Button();
            this.button4 = new System.Windows.Forms.Button();
            this.led6 = new System.Windows.Forms.Button();
            this.led8 = new System.Windows.Forms.Button();
            this.led7 = new System.Windows.Forms.Button();
            this.label4 = new System.Windows.Forms.Label();
            this.send_lighttime = new System.Windows.Forms.Button();
            this.lighttime = new System.Windows.Forms.TextBox();
            this.textBox2 = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.groupBox4 = new System.Windows.Forms.GroupBox();
            this.label6 = new System.Windows.Forms.Label();
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.groupBox3.SuspendLayout();
            this.groupBox4.SuspendLayout();
            this.SuspendLayout();
            // 
            // connect
            // 
            this.connect.BackColor = System.Drawing.Color.IndianRed;
            this.connect.Font = new System.Drawing.Font("Microsoft New Tai Lue", 14.25F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))));
            this.connect.Location = new System.Drawing.Point(557, 13);
            this.connect.Name = "connect";
            this.connect.Size = new System.Drawing.Size(135, 56);
            this.connect.TabIndex = 0;
            this.connect.Text = "Connect";
            this.connect.UseVisualStyleBackColor = false;
            this.connect.Click += new System.EventHandler(this.connect_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft New Tai Lue", 14.25F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))));
            this.label1.Location = new System.Drawing.Point(17, 29);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(104, 25);
            this.label1.TabIndex = 1;
            this.label1.Text = "Com Gate:";
            // 
            // listcom
            // 
            this.listcom.FormattingEnabled = true;
            this.listcom.Location = new System.Drawing.Point(137, 33);
            this.listcom.Name = "listcom";
            this.listcom.Size = new System.Drawing.Size(121, 21);
            this.listcom.TabIndex = 2;
            // 
            // listbaud
            // 
            this.listbaud.FormattingEnabled = true;
            this.listbaud.Location = new System.Drawing.Point(412, 33);
            this.listbaud.Name = "listbaud";
            this.listbaud.Size = new System.Drawing.Size(121, 21);
            this.listbaud.TabIndex = 4;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft New Tai Lue", 14.25F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))));
            this.label2.Location = new System.Drawing.Point(301, 29);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(98, 25);
            this.label2.TabIndex = 3;
            this.label2.Text = "Baudrate:";
            // 
            // serialPort1
            // 
            this.serialPort1.DataReceived += new System.IO.Ports.SerialDataReceivedEventHandler(this.serialPort1_DataReceived);
            // 
            // textBox1
            // 
            this.textBox1.Location = new System.Drawing.Point(141, 105);
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new System.Drawing.Size(100, 20);
            this.textBox1.TabIndex = 6;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft New Tai Lue", 14.25F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))));
            this.label3.Location = new System.Drawing.Point(52, 101);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(72, 25);
            this.label3.TabIndex = 7;
            this.label3.Text = "Count:";
            // 
            // zedGraphControl1
            // 
            this.zedGraphControl1.Location = new System.Drawing.Point(299, 180);
            this.zedGraphControl1.Name = "zedGraphControl1";
            this.zedGraphControl1.ScrollGrace = 0D;
            this.zedGraphControl1.ScrollMaxX = 0D;
            this.zedGraphControl1.ScrollMaxY = 0D;
            this.zedGraphControl1.ScrollMaxY2 = 0D;
            this.zedGraphControl1.ScrollMinX = 0D;
            this.zedGraphControl1.ScrollMinY = 0D;
            this.zedGraphControl1.ScrollMinY2 = 0D;
            this.zedGraphControl1.Size = new System.Drawing.Size(513, 395);
            this.zedGraphControl1.TabIndex = 14;
            this.zedGraphControl1.UseExtendedPrintDialog = true;
            // 
            // led1
            // 
            this.led1.Location = new System.Drawing.Point(8, 22);
            this.led1.Name = "led1";
            this.led1.Size = new System.Drawing.Size(99, 35);
            this.led1.TabIndex = 9;
            this.led1.Text = "Led1 on";
            this.led1.UseVisualStyleBackColor = true;
            this.led1.Click += new System.EventHandler(this.led1_Click);
            // 
            // led2
            // 
            this.led2.Location = new System.Drawing.Point(141, 22);
            this.led2.Name = "led2";
            this.led2.Size = new System.Drawing.Size(105, 35);
            this.led2.TabIndex = 10;
            this.led2.Text = "Led2 on";
            this.led2.UseVisualStyleBackColor = true;
            this.led2.Click += new System.EventHandler(this.led2_Click);
            // 
            // led3
            // 
            this.led3.Location = new System.Drawing.Point(8, 80);
            this.led3.Name = "led3";
            this.led3.Size = new System.Drawing.Size(99, 33);
            this.led3.TabIndex = 10;
            this.led3.Text = "Led3 on";
            this.led3.UseVisualStyleBackColor = true;
            this.led3.Click += new System.EventHandler(this.led3_Click);
            // 
            // led4
            // 
            this.led4.Location = new System.Drawing.Point(143, 80);
            this.led4.Name = "led4";
            this.led4.Size = new System.Drawing.Size(103, 33);
            this.led4.TabIndex = 10;
            this.led4.Text = "Led4 on";
            this.led4.UseVisualStyleBackColor = true;
            this.led4.Click += new System.EventHandler(this.led4_Click);
            // 
            // button4
            // 
            this.button4.Location = new System.Drawing.Point(8, 141);
            this.button4.Name = "button4";
            this.button4.Size = new System.Drawing.Size(99, 33);
            this.button4.TabIndex = 10;
            this.button4.Text = "Led5 on";
            this.button4.UseVisualStyleBackColor = true;
            this.button4.Click += new System.EventHandler(this.button4_Click);
            // 
            // led6
            // 
            this.led6.Location = new System.Drawing.Point(143, 141);
            this.led6.Name = "led6";
            this.led6.Size = new System.Drawing.Size(103, 33);
            this.led6.TabIndex = 10;
            this.led6.Text = "Led6 on";
            this.led6.UseVisualStyleBackColor = true;
            this.led6.Click += new System.EventHandler(this.led6_Click);
            // 
            // led8
            // 
            this.led8.Location = new System.Drawing.Point(143, 192);
            this.led8.Name = "led8";
            this.led8.Size = new System.Drawing.Size(103, 36);
            this.led8.TabIndex = 10;
            this.led8.Text = "Led8 on";
            this.led8.UseVisualStyleBackColor = true;
            this.led8.Click += new System.EventHandler(this.led8_Click);
            // 
            // led7
            // 
            this.led7.Location = new System.Drawing.Point(8, 192);
            this.led7.Name = "led7";
            this.led7.Size = new System.Drawing.Size(99, 36);
            this.led7.TabIndex = 10;
            this.led7.Text = "Led7 on";
            this.led7.UseVisualStyleBackColor = true;
            this.led7.Click += new System.EventHandler(this.led7_Click);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft New Tai Lue", 14.25F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))));
            this.label4.Location = new System.Drawing.Point(8, 27);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(133, 25);
            this.label4.TabIndex = 11;
            this.label4.Text = "Light time (s):";
            this.label4.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // send_lighttime
            // 
            this.send_lighttime.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.send_lighttime.Font = new System.Drawing.Font("Microsoft New Tai Lue", 14.25F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))));
            this.send_lighttime.Location = new System.Drawing.Point(306, 17);
            this.send_lighttime.Name = "send_lighttime";
            this.send_lighttime.Size = new System.Drawing.Size(100, 49);
            this.send_lighttime.TabIndex = 13;
            this.send_lighttime.Text = "Send";
            this.send_lighttime.UseVisualStyleBackColor = false;
            this.send_lighttime.Click += new System.EventHandler(this.send_lighttime_Click);
            // 
            // lighttime
            // 
            this.lighttime.Location = new System.Drawing.Point(155, 33);
            this.lighttime.Name = "lighttime";
            this.lighttime.Size = new System.Drawing.Size(109, 20);
            this.lighttime.TabIndex = 15;
            // 
            // textBox2
            // 
            this.textBox2.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textBox2.Location = new System.Drawing.Point(141, 37);
            this.textBox2.Name = "textBox2";
            this.textBox2.Size = new System.Drawing.Size(100, 29);
            this.textBox2.TabIndex = 16;
            this.textBox2.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Microsoft New Tai Lue", 14.25F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))));
            this.label5.Location = new System.Drawing.Point(3, 37);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(132, 25);
            this.label5.TabIndex = 17;
            this.label5.Text = "Temperature:";
            // 
            // groupBox1
            // 
            this.groupBox1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(224)))), ((int)(((byte)(224)))));
            this.groupBox1.Controls.Add(this.label5);
            this.groupBox1.Controls.Add(this.textBox2);
            this.groupBox1.Controls.Add(this.label3);
            this.groupBox1.Controls.Add(this.textBox1);
            this.groupBox1.Location = new System.Drawing.Point(17, 421);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(264, 154);
            this.groupBox1.TabIndex = 18;
            this.groupBox1.TabStop = false;
            // 
            // groupBox2
            // 
            this.groupBox2.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(224)))), ((int)(((byte)(224)))));
            this.groupBox2.Controls.Add(this.led1);
            this.groupBox2.Controls.Add(this.led2);
            this.groupBox2.Controls.Add(this.led3);
            this.groupBox2.Controls.Add(this.led6);
            this.groupBox2.Controls.Add(this.led4);
            this.groupBox2.Controls.Add(this.led7);
            this.groupBox2.Controls.Add(this.button4);
            this.groupBox2.Controls.Add(this.led8);
            this.groupBox2.Font = new System.Drawing.Font("Microsoft New Tai Lue", 14.25F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))));
            this.groupBox2.ForeColor = System.Drawing.SystemColors.MenuHighlight;
            this.groupBox2.Location = new System.Drawing.Point(17, 180);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(264, 235);
            this.groupBox2.TabIndex = 19;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "led run";
            // 
            // groupBox3
            // 
            this.groupBox3.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(224)))), ((int)(((byte)(224)))));
            this.groupBox3.Controls.Add(this.listcom);
            this.groupBox3.Controls.Add(this.label1);
            this.groupBox3.Controls.Add(this.label2);
            this.groupBox3.Controls.Add(this.listbaud);
            this.groupBox3.Controls.Add(this.connect);
            this.groupBox3.Location = new System.Drawing.Point(17, 12);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(705, 76);
            this.groupBox3.TabIndex = 20;
            this.groupBox3.TabStop = false;
            this.groupBox3.Text = "Set up";
            // 
            // groupBox4
            // 
            this.groupBox4.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(224)))), ((int)(((byte)(224)))));
            this.groupBox4.Controls.Add(this.send_lighttime);
            this.groupBox4.Controls.Add(this.label4);
            this.groupBox4.Controls.Add(this.lighttime);
            this.groupBox4.Location = new System.Drawing.Point(17, 102);
            this.groupBox4.Name = "groupBox4";
            this.groupBox4.Size = new System.Drawing.Size(415, 72);
            this.groupBox4.TabIndex = 21;
            this.groupBox4.TabStop = false;
            this.groupBox4.Text = "Run time";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Microsoft Sans Serif", 15.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label6.ForeColor = System.Drawing.Color.Blue;
            this.label6.Location = new System.Drawing.Point(523, 119);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(289, 25);
            this.label6.TabIndex = 22;
            this.label6.Text = "Tô Hoàng Bửu-N21DCVT009";
            // 
            // display
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.Silver;
            this.ClientSize = new System.Drawing.Size(824, 592);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.groupBox4);
            this.Controls.Add(this.groupBox3);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.zedGraphControl1);
            this.Name = "display";
            this.Text = "Display";
            this.Load += new System.EventHandler(this.display_Load);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            this.groupBox3.ResumeLayout(false);
            this.groupBox3.PerformLayout();
            this.groupBox4.ResumeLayout(false);
            this.groupBox4.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button connect;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.ComboBox listcom;
        private System.Windows.Forms.ComboBox listbaud;
        private System.Windows.Forms.Label label2;
        private System.IO.Ports.SerialPort serialPort1;
        private System.Windows.Forms.TextBox textBox1;
        private System.Windows.Forms.Label label3;
        private ZedGraph.ZedGraphControl zedGraphControl1;
        private System.Windows.Forms.Button led1;
        private System.Windows.Forms.Button led2;
        private System.Windows.Forms.Button led3;
        private System.Windows.Forms.Button led4;
        private System.Windows.Forms.Button button4;
        private System.Windows.Forms.Button led6;
        private System.Windows.Forms.Button led8;
        private System.Windows.Forms.Button led7;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Button send_lighttime;
        private System.Windows.Forms.TextBox lighttime;
        private System.Windows.Forms.TextBox textBox2;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.GroupBox groupBox3;
        private System.Windows.Forms.GroupBox groupBox4;
        private System.Windows.Forms.Label label6;
    }
}

