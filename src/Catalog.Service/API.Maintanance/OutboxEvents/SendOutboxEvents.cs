using ApplicationCore.Outbox.Commands;
using MediatR;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;

namespace API.Maintanance.OutboxEvents;

public class SendOutboxEvents(ILogger<SendOutboxEvents> logger, IMediator sender)
{
    [Function("SendOutboxEvents")]
    public async Task<IActionResult> Run([TimerTrigger("0 */5 * * * *")] TimerInfo myTimer)
    {
        logger.LogInformation("{FunctionName} was called", nameof(SendOutboxEvents));

        var command = new SendOutboxEventsCommand();
        await sender.Send(command);

        if (myTimer.ScheduleStatus is not null)
            logger.LogInformation($"Next timer schedule at: {myTimer.ScheduleStatus.Next}");

        return new OkObjectResult(true);
    }
}
