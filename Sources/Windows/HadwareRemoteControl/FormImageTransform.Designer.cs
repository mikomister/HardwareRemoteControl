namespace HadwareRemoteControl
{
    partial class FormImageTransform
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FormImageTransform));
            toolStrip1 = new System.Windows.Forms.ToolStrip();
            tsbUseTransform = new System.Windows.Forms.ToolStripDropDownButton();
            dontUseTransformToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            useTransformToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            tsbZoomIn = new System.Windows.Forms.ToolStripButton();
            tsbZoomOut = new System.Windows.Forms.ToolStripButton();
            pbScreen = new System.Windows.Forms.PictureBox();
            toolStrip1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)pbScreen).BeginInit();
            SuspendLayout();
            // 
            // toolStrip1
            // 
            toolStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] { tsbUseTransform, toolStripSeparator1, tsbZoomIn, tsbZoomOut });
            toolStrip1.Location = new System.Drawing.Point(0, 0);
            toolStrip1.Name = "toolStrip1";
            toolStrip1.Size = new System.Drawing.Size(1045, 25);
            toolStrip1.TabIndex = 0;
            toolStrip1.Text = "toolStrip1";
            // 
            // tsbUseTransform
            // 
            tsbUseTransform.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] { dontUseTransformToolStripMenuItem, useTransformToolStripMenuItem });
            tsbUseTransform.Image = (System.Drawing.Image)resources.GetObject("tsbUseTransform.Image");
            tsbUseTransform.ImageTransparentColor = System.Drawing.Color.Magenta;
            tsbUseTransform.Name = "tsbUseTransform";
            tsbUseTransform.Size = new System.Drawing.Size(182, 22);
            tsbUseTransform.Text = "toolStripDropDownButton1";
            // 
            // dontUseTransformToolStripMenuItem
            // 
            dontUseTransformToolStripMenuItem.Image = (System.Drawing.Image)resources.GetObject("dontUseTransformToolStripMenuItem.Image");
            dontUseTransformToolStripMenuItem.Name = "dontUseTransformToolStripMenuItem";
            dontUseTransformToolStripMenuItem.Size = new System.Drawing.Size(184, 22);
            dontUseTransformToolStripMenuItem.Tag = "0";
            dontUseTransformToolStripMenuItem.Text = "Don't Use Transform";
            dontUseTransformToolStripMenuItem.Click += onTransformClick;
            // 
            // useTransformToolStripMenuItem
            // 
            useTransformToolStripMenuItem.Image = (System.Drawing.Image)resources.GetObject("useTransformToolStripMenuItem.Image");
            useTransformToolStripMenuItem.Name = "useTransformToolStripMenuItem";
            useTransformToolStripMenuItem.Size = new System.Drawing.Size(184, 22);
            useTransformToolStripMenuItem.Tag = "1";
            useTransformToolStripMenuItem.Text = "Use Transform";
            useTransformToolStripMenuItem.Click += onTransformClick;
            // 
            // toolStripSeparator1
            // 
            toolStripSeparator1.Name = "toolStripSeparator1";
            toolStripSeparator1.Size = new System.Drawing.Size(6, 25);
            // 
            // tsbZoomIn
            // 
            tsbZoomIn.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            tsbZoomIn.Image = (System.Drawing.Image)resources.GetObject("tsbZoomIn.Image");
            tsbZoomIn.ImageTransparentColor = System.Drawing.Color.Magenta;
            tsbZoomIn.Name = "tsbZoomIn";
            tsbZoomIn.Size = new System.Drawing.Size(23, 22);
            tsbZoomIn.Text = "toolStripButton1";
            tsbZoomIn.Click += tsbZoomIn_Click;
            // 
            // tsbZoomOut
            // 
            tsbZoomOut.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            tsbZoomOut.Image = (System.Drawing.Image)resources.GetObject("tsbZoomOut.Image");
            tsbZoomOut.ImageTransparentColor = System.Drawing.Color.Magenta;
            tsbZoomOut.Name = "tsbZoomOut";
            tsbZoomOut.Size = new System.Drawing.Size(23, 22);
            tsbZoomOut.Text = "toolStripButton2";
            tsbZoomOut.Click += tsbZoomOut_Click;
            // 
            // pbScreen
            // 
            pbScreen.BackColor = System.Drawing.Color.Black;
            pbScreen.Dock = System.Windows.Forms.DockStyle.Fill;
            pbScreen.Location = new System.Drawing.Point(0, 25);
            pbScreen.Name = "pbScreen";
            pbScreen.Size = new System.Drawing.Size(1045, 692);
            pbScreen.TabIndex = 1;
            pbScreen.TabStop = false;
            pbScreen.Paint += pbScreen_Paint;
            pbScreen.MouseDown += pbScreen_MouseDown;
            pbScreen.MouseMove += pbScreen_MouseMove;
            pbScreen.MouseUp += pbScreen_MouseUp;
            pbScreen.Resize += pbScreen_Resize;
            // 
            // FormImageTransform
            // 
            AutoScaleDimensions = new System.Drawing.SizeF(7F, 16F);
            AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            ClientSize = new System.Drawing.Size(1045, 717);
            Controls.Add(pbScreen);
            Controls.Add(toolStrip1);
            Icon = (System.Drawing.Icon)resources.GetObject("$this.Icon");
            Name = "FormImageTransform";
            StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            Text = "Transform Image Settings";
            Load += FormImageTransform_Load;
            toolStrip1.ResumeLayout(false);
            toolStrip1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)pbScreen).EndInit();
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private System.Windows.Forms.ToolStrip toolStrip1;
        private System.Windows.Forms.ToolStripMenuItem dontUseTransformToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem useTransformToolStripMenuItem;
        private System.Windows.Forms.ToolStripDropDownButton tsbUseTransform;
        private System.Windows.Forms.PictureBox pbScreen;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.ToolStripButton tsbZoomIn;
        private System.Windows.Forms.ToolStripButton tsbZoomOut;
    }
}