using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HadwareRemoteControl
{
    public static class Helpers
    {
		public static string CutLeft(this string Text, string Delimiter)
        {
            return Text.Split(Delimiter, 2)[0];
        }

        public static void SplitTwo(this string Text, string Delimiter, out string Left, out string Right)
        {
            var parts = Text.Split(Delimiter, 2);
            Left = parts[0];
            if (parts.Length > 1)
            {
                Right = parts[1];
            }
            else
            {
                Right = "";
            }
        }

        public static void SplitTwoTrimed(this string Text, string Delimiter, out string Left, out string Right)
        {
            var parts = Text.Split(Delimiter, 2);
            Left = parts[0].Trim();
            if (parts.Length > 1)
            {
                Right = parts[1].Trim();
            }
            else
            {
                Right = "";
            }
        }

        public static string CutRight(this string Text, string Delimiter)
        {
            return Text.Split(Delimiter, 2).Last();
        }

        public static Int64 STR2INT64_EX(string s)
		{
			Int64 value = 0;
			if (s != null)
			{
				int len = s.Length;
				if (len > 0)
				{
					if (s[0] == '-')
					{
						for (int i = 1; i < len; i++)
						{
							if (s[i] < '0' || s[i] > '9')
							{
								break;
							}
							value = value * 10 + (s[i] - '0');
						}
						return -value;
					}
					else
					{
						for (int i = 0; i < len; i++)
						{
							if (s[i] < '0' || s[i] > '9')
							{
								break;
							}
							value = value * 10 + (s[i] - '0');
						}
						return value;
					}
				}
			}
			return 0;
		}
		public static int STR2INT_EX(string s)
		{
			int value = 0;
			int len = s.Length;
			if (s != null)
			{
				if (len > 0)
				{
					if (s[0] == '-')
					{
						for (int i = 1; i < len; i++)
						{
							if (s[i] < '0' || s[i] > '9')
							{
								break;
							}
							value = value * 10 + (s[i] - '0');
						}
						return -value;
					}
					else
					{
						for (int i = 0; i < len; i++)
						{
							if (s[i] < '0' || s[i] > '9')
							{
								break;
							}
							value = value * 10 + (s[i] - '0');
						}
						return value;
					}
				}
			}
			return 0;
		}

		public static bool STR2BOOL(string _str, bool Default = false)
		{
			if (_str == null)
			{
				return Default;
			}
			if (_str.Length == 0)
			{
				return Default;
			}
			if (_str == "true" || _str == "True")
			{
				return true;
			}
			else if (_str == "false" || _str == "False")
			{
				return false;
			}
			return (STR2INT_EX(_str) != 0);
		}

		public static double STR2DOUBLE(string _str, double def_val = 0.0)
		{
			if (_str == null)
			{
				return def_val;
			}
			double outVal;
			if (!double.TryParse(_str.Replace(',', '.'), NumberStyles.Any, CultureInfo.InvariantCulture, out outVal))
			{
				outVal = def_val;
			}
			return outVal;
		}

        public static long ToInt64(this string Text)
        {
            return STR2INT64_EX(Text);
        }

        public static int ToInt32(this string Text)
        {
            return STR2INT_EX(Text);
        }

		public static double ToDouble(this string Text)
        {
            return STR2DOUBLE(Text);
        }

		public static float ToFloat(this string Text)
        {
            return (float)STR2DOUBLE(Text);
        }

        public static bool ToBool(this string Text)
        {
            return STR2BOOL(Text);
        }
    }
}
