using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Windows.Forms;
using System.Xml;

namespace prjWin_NationalBank_Rm
{
    /*
    * This project uses the following licenses:
    *  MIT License
    *  Copyright (c) 2017 Ricardo Mendoza 
    *  Montréal Québec Canada
    *  Institut Teccart
    *  www.teccart.qc.ca
    *  Août 2017
   */
    public static class clsDataSource
    {
        // Attributes
        // public static clsListPaidAccounts listPaidAccounts = new clsListPaidAccounts();
        public static clsListDirecteurs listDirectors = new clsListDirecteurs();
        public static clsListAdmins listAdmins = new clsListAdmins();
        public static clsListAgencies listAgencies = new clsListAgencies();
        public static clsListEmployees listEmployees = new clsListEmployees();

        /// <summary>
        /// Get directors information from txt document
        /// </summary>
        /// <returns>listDirectors</returns>
        public static clsListDirecteurs fnGetDirecteurs()
        {
            string number, name, lastName;
            double salary;
            string photo;
            StreamReader myTxt = new StreamReader("2.infoDirector.txt");
            //  clsListDirecteurs tmp = new clsListDirecteurs();
            while (!myTxt.EndOfStream)
            {
                number = myTxt.ReadLine();
                name = myTxt.ReadLine();
                lastName = myTxt.ReadLine();
                salary = Convert.ToDouble(myTxt.ReadLine());
                photo = myTxt.ReadLine();

                listDirectors.fncAdd(new clsDirecteur(number, name, lastName, salary, photo));
            }
            // MessageBox.Show("Directors : " + tmp.Quantity.ToString());
            // MessageBox.Show("Photo string : " + tmp.Elements);
            myTxt.Close();
            return listDirectors;
        }
        /// <summary>
        /// Get agencies information from txt document
        /// </summary>
        /// <returns>listAgencies</returns>
        public static clsListAgencies fncGetAgencies()
        {
            string agencyNumber, agencyName, agencyAddress;
            StreamReader myTxt = new StreamReader("3.infoAgency.txt");
            while (!myTxt.EndOfStream)
            {
                agencyNumber = myTxt.ReadLine();
                agencyName = myTxt.ReadLine();
                agencyAddress = myTxt.ReadLine();
                listAgencies.fncAdd(new clsAgency(agencyNumber, agencyName, agencyAddress));
            }
            myTxt.Close();
            //MessageBox.Show("Agencies : " + tmp.Quantity.ToString());
            return listAgencies;
        }
        /// <summary>
        /// Get admins information from txt document
        /// </summary>
        /// <returns>listAdmins</returns>
        public static clsListAdmins fncGetAdmins()
        {
            string adminNumber, adminName, adminLastName, adminEmail, adminPassword, adminPhoto;
            int Tik_Tak;
            StreamReader myTxt = new StreamReader("4.infoAdmin.txt");

            while (!myTxt.EndOfStream)
            {
                Tik_Tak = 3;
                adminNumber = myTxt.ReadLine();
                adminName = myTxt.ReadLine();
                adminLastName = myTxt.ReadLine();
                adminEmail = myTxt.ReadLine();
                adminPassword = myTxt.ReadLine();
                adminPhoto = myTxt.ReadLine();
                listAdmins.fncAdd(new clsAdmin(Tik_Tak, adminNumber, adminName, adminLastName, adminEmail, adminPassword, adminPhoto));
            }
            myTxt.Close();
            //MessageBox.Show("Admins : " + tmp.Quantity.ToString());
            return listAdmins;
        }
        /// <summary>
        /// Get employees information from txt document
        /// </summary>
        /// <returns>listEmployees</returns>
        public static clsListEmployees fncGetEmployees(string agencyNumber)
        {
            string agencyNbr, number, name, lastName;
            string photo;
            int day, month, year;
            StreamReader myTxt = new StreamReader("5.infoEmployee.txt");
            while (!myTxt.EndOfStream)
            {
                agencyNbr = myTxt.ReadLine();
                number = myTxt.ReadLine();
                name = myTxt.ReadLine();
                lastName = myTxt.ReadLine();
                photo = myTxt.ReadLine();
                day = Convert.ToInt32(myTxt.ReadLine());
                month = Convert.ToInt32(myTxt.ReadLine());
                year = Convert.ToInt32(myTxt.ReadLine());
                if (agencyNbr == agencyNumber)
                {
                    listEmployees.fncAdd(new clsEmployee(number, name, lastName, photo, day, month, year));
                }
            }
            myTxt.Close();
            //MessageBox.Show("Employees : " + tmp.Quantity.ToString());
            return listEmployees;
        }
        /// <summary>
        /// Get clients information from txt document
        /// </summary>
        /// <returns>listClients</returns>
        public static clsListClients fncGetClients(string agencyNumber)
        {
            // variables without employee
            string agNbr, number, name, lastName, nip, address;
            // variables employee
            string numberEmp, nameEmp, lastNameEmp, photo;
            int day, month, year;
            StreamReader myTxt = new StreamReader("6.infoClient.txt");
            clsListClients listClients = new clsListClients();
            while (!myTxt.EndOfStream)
            {
                // values from txt employee -> 6.infoClient - Copy.txt
                agNbr = myTxt.ReadLine();
                number = myTxt.ReadLine();
                name = myTxt.ReadLine();
                lastName = myTxt.ReadLine();
                nip = myTxt.ReadLine();
                address = myTxt.ReadLine();
                // values from txt employee -> 6.infoClient.txt
                numberEmp = myTxt.ReadLine();
                nameEmp = myTxt.ReadLine();
                lastNameEmp = myTxt.ReadLine();
                photo = myTxt.ReadLine();
                day = Convert.ToInt32(myTxt.ReadLine());
                month = Convert.ToInt32(myTxt.ReadLine());
                year = Convert.ToInt32(myTxt.ReadLine());
                if (agNbr == agencyNumber)
                {
                    listClients.fncAdd(new clsClient(number, name, lastName, nip, address, numberEmp, nameEmp, lastNameEmp, photo, day, month, year));
                }
            }
            //MessageBox.Show("Clients : " + tmp.Quantity.ToString());
            myTxt.Close();
            return listClients;
        }
        /// <summary>
        /// Get paid accounts information from txt document
        /// </summary>
        /// <returns>listPaidAccounts</returns>
        public static clsListPaidAccounts fncGetPaidAccounts(string clientNumber)
        {
            string clNbr;
            double interestRate;
            string number, type;
            double balance;
            int day, month, year;
            StreamReader myTxt = new StreamReader("7.infoPaidAccount.txt");
            clsListPaidAccounts listPaidAccounts = new clsListPaidAccounts();
            while (!myTxt.EndOfStream)
            {
                clNbr = myTxt.ReadLine();
                double interestrate = Convert.ToDouble(myTxt.ReadLine());
                interestRate = interestrate;
                number = myTxt.ReadLine();
                type = myTxt.ReadLine();
                balance = Convert.ToDouble(myTxt.ReadLine());
                day = Convert.ToInt32(myTxt.ReadLine());
                month = Convert.ToInt32(myTxt.ReadLine());
                year = Convert.ToInt32(myTxt.ReadLine());

                if (clNbr == clientNumber)
                {
                    /// <summary>
                    /// Constructor that takes seven arguments -> in the Function protected abstract : Pay interest.
                    /// </summary>
                    listPaidAccounts.fncAdd(new clsPaidAccount(interestRate, number, type, balance, day, month, year));
                }
            }
            myTxt.Close();
            //MessageBox.Show("PaidAccounts : " + tmp.Quantity.ToString());
            return listPaidAccounts;
        }
        /// <summary>
        /// Get un paid accounts information from txt document
        /// </summary>
        /// <returns>listUnPaidAccounts</returns>
        public static clsListUnpaidAccounts fncGetUnpaidAccounts(string clientNumber)
        {
            string clNbr;
            double commission;
            int overdraft;
            string number, type;
            double balance;
            int day, month, year;
            StreamReader myTxt = new StreamReader("8.infoUnPaidAccount.txt");
            clsListUnpaidAccounts listUnPaidAccounts = new clsListUnpaidAccounts();
            while (!myTxt.EndOfStream)
            {
                clNbr = myTxt.ReadLine();
                commission = Convert.ToDouble(myTxt.ReadLine());
                overdraft = Convert.ToInt32(myTxt.ReadLine());
                number = myTxt.ReadLine();
                type = myTxt.ReadLine();
                balance = Convert.ToDouble(myTxt.ReadLine());
                day = Convert.ToInt32(myTxt.ReadLine());
                month = Convert.ToInt32(myTxt.ReadLine());
                year = Convert.ToInt32(myTxt.ReadLine());

                if (clNbr == clientNumber)
                {
                    /// <summary>
                    /// Constructor that takes eigth arguments -> in the Function protected abstract : Charge  commission.
                    /// </summary>
                    listUnPaidAccounts.fncAdd(new clsUnpaidAccount(commission, overdraft, number, type, balance, day, month, year));
                }
            }
            myTxt.Close();
            // MessageBox.Show("UnPaidAccounts : " + tmp.Quantity.ToString());
            return listUnPaidAccounts;
        }
        public static string fncEmptyConstructor()
        {
            return "Do not exit";
        }
        /// <summary>
        /// Function fncTodayDate() -> Get the now date.
        /// </summary>
        /// <returns>todayDate</returns>
        public static DateTime fncTodayDate()
        {
            DateTime todayDate = DateTime.Now;
            return todayDate;
        }
    }
}
