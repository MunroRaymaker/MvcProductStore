using System;
using System.Threading.Tasks;
using Microsoft.AspNet.Identity;

namespace MvcProductStore.Identity
{
    public class EmailService : IIdentityMessageService
    {
        public Task SendAsync(IdentityMessage message)
        {
            // TODO Plug in your email service here to send an email.
            try
            {
                //SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587);

                //smtpClient.Credentials = new System.Net.NetworkCredential("youremail@gmail.com", "aPassword");
                //smtpClient.UseDefaultCredentials = true;
                //smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
                //smtpClient.EnableSsl = true;
                //MailMessage mail = new MailMessage
                //{
                //    From = new MailAddress("noreply@runnershop.com", "Runner Shop"),
                //    Subject = message.Subject,
                //    Body = message.Body,
                //    IsBodyHtml = true
                //};

                //mail.To.Add(new MailAddress(message.Destination));

                //smtpClient.Send(mail);

            }
            catch (Exception ex)
            {
                throw new Exception("Unable to send email. " + ex.Message + ". Msg was: " + message.Body);
            }

            return Task.FromResult(0);
        }
    }
}
