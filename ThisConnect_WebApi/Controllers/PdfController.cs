using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Reflection.Metadata;
using QuestPDF.Infrastructure;
using System.ComponentModel;
using QuestPDF.Drawing;
using QuestPDF.Fluent;
using QuestPDF.Helpers;
using QuestPDF.Infrastructure;

namespace ThisConnect_WebApi.Controllers
{

    [Route("api/[controller]")]
    [ApiController]
    public class PdfController : ControllerBase
    {
        
        [HttpGet("generatepdf")]
        public async Task<IActionResult> GeneratePDF(string QrID)
        {
            InvoiceDocument document = new InvoiceDocument();
            
            
        }

    }

    public class InvoiceDocument : IDocument
    {
        public DocumentMetadata GetMetadata() => DocumentMetadata.Default;
        public DocumentSettings GetSettings() => DocumentSettings.Default;

        public void Compose(IDocumentContainer container)
        {
            container
                .Page(page =>
                {
                    page.Margin(50);

                    page.Header().Height(100).Background(Colors.Grey.Lighten1);
                    page.Content().Background(Colors.Grey.Lighten3);
                    page.Footer().Height(50).Background(Colors.Grey.Lighten1);
                });
        }
    }
    public interface IDocument
    {
        DocumentMetadata GetMetadata();
        DocumentSettings GetSettings();
        void Compose(IDocumentContainer container);
    }
}
