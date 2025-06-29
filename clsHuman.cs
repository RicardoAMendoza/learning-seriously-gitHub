using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace prjWin_NationalBank_Rm
{ 
    /// <summary>
    /// Ricardo Mendoza
    /// Strategy Design Patern
    /// Institut Teccart
    /// www.teccart.qc.ca
    /// Montréal, Québec
    /// Août 2017
    /// </summary>
    public abstract class clsHuman
    {
        /// <summary>
        /// Fields
        /// </summary>
        private string Number;
        private string Name;
        private string LastName;
        private string Photo;
        /// <summary>
        /// Constructor that takes 4 arguments : Photo constructor.
        /// </summary>
        public clsHuman(string vNumber, string vName, string vLastName, string vPhoto)
        {
            Number = vNumber;
            Name = vName;
            LastName = vLastName;
            Photo = vPhoto;
        }
        /// <summary>
        /// Constructor that takes 3 arguments.
        /// </summary>
        public clsHuman(string vNumber, string vName, string vLastName)
        {
            Number = vNumber;
            Name = vName;
            LastName = vLastName;
        }
        /// <summary>
        /// Constructor that takes no arguments.
        /// </summary>
        public clsHuman()
        {
            Number = clsDataSource.fncEmptyConstructor();
            Name = clsDataSource.fncEmptyConstructor();
            LastName = clsDataSource.fncEmptyConstructor();
        }
        /// <summary>
        /// Properties.
        /// </summary>
        public string vNumber
        {
            get { return Number; }
            set { Number = value; }
        }
        public string vName
        {
            get { return Name; }
            set { Name = value; }
        }
        public string vLastName
        {
            get { return LastName; }
            set { LastName = value; }
        }
        /// <summary>
        /// Constructor that takes 4 arguments : Photo constructor getter and setter.
        /// </summary>
        public string vPhoto
        {
            get { return Photo; }
            set { Photo = value; }
        }
        /// <summary>
        /// Virtual Methods.
        /// fncCreateaHuman(string vName, string vLastName) -> constructs a human 
        /// </summary>
        /// <param name="vName"></param>
        /// <param name="vLastName"></param>
        public virtual void fncCreateaHuman(string vName, string vLastName)
        {
            Name = vName;
            LastName = vLastName;
        }
        /// <summary>
        /// Override Methods.
        /// fncDisplayHuman() -> info from a human.
        /// </summary>
        /// <returns>info</returns>
        public virtual string fncDisplayHuman()
        {
            string info = "";
            // info = info + "\ndadysCounter : " + dadysCounter;
            info += "\nClient Number : " + Number;
            info = info + "\nName : " + Name;
            info = info + "\nLast Name : " + LastName;
            return info;
        }
        /// <summary>
        /// Constructor that takes 4 arguments : Photo constructor getter and setter.
        /// Override Methods
        /// fncDisplayHumanPhoto() -> info from a human.
        /// </summary>
        /// /// <returns>info with Phot string</returns>
        public virtual string fncDisplayHumanPhoto()
        {
            string info = "";
            //  info = info + "\ndadysCounter : " + dadysCounter;
            info += "\nNumber : " + Number;
            info = info + "\nName : " + Name;
            info = info + "\nLast Name : " + LastName;
            info = info + "\nPhoto : " + Photo;
            return info;
        }

    }
}
