using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
//using System.Windows.Forms; // MsgBox

namespace ConsoleCalculator
{
    public class Calculator
    {
        static void Main(string[] args)
        {
			Console.WriteLine("Calculatrice")
			Console.WriteLine("premier number")
			double a = Convet.ToInt32(Console.ReadLine());
			Console.WriteLine("deuxieme number")
			double b = Convet.ToInt32(Console.ReadLine());
			Console.WriteLine("Calcul")
			Console.WriteLine("sum\n rest\n mult n\ Div")
			
			int option = Convet.ToInt32(Console.ReadLine());
			switch (option)
			case 1:
			Add(a, b)
			break:
			case 2:
			Substract( a,  b)
			break:
			case 3:
			Multiply(a,  b)
			break:
			case 4:
			Divide( a, b)
			break:
        }

        public double Add(double a, double b)
        {
			double resultat =0;
			resultat = a+b;
            return resultat;
        }

        public double Substract(double a, double b)
        {
			double resultat =0;
			resultat = a-b;
            return resultat;
        }

        public double Multiply(double a, double b)
        {
			double resultat =0;
			resultat = a*b;
            return resultat;
        }

        public double Divide(double a, double b)
        {
			double resultat =0;
			
			if(a>0 || b<0)
			{
				resultat = a/b;
			}
			else
			{
				return null;
				//MessageBox.Show("La division par zéro n'existe pas");
			}
            return resultat;
        }
    }
}
