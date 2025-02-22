﻿using System.Diagnostics.CodeAnalysis;
using System.Text.Json;
using Cart.Service.Platform.Serialization;
using Microsoft.AspNetCore.Mvc.ApiExplorer;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.OpenApi.Models;
using Swashbuckle.AspNetCore.SwaggerGen;

namespace Cart.Service.Platform.Swagger;

// Source file: https://github.com/dotnet/aspnet-api-versioning/blob/main/examples/AspNetCore/WebApi/MinimalOpenApiExample/SwaggerDefaultValues.cs
public class SwaggerDefaultValues : IOperationFilter
{
    [SuppressMessage("Trimming", "IL2026:Members annotated with 'RequiresUnreferencedCodeAttribute' require dynamic access otherwise can break functionality when trimming application code", Justification = "<Pending>")]
    [SuppressMessage("AOT", "IL3050:Calling members annotated with 'RequiresDynamicCodeAttribute' may break functionality when AOT compiling.", Justification = "<Pending>")]
    public void Apply(OpenApiOperation operation, OperationFilterContext context)
    {
        ArgumentNullException.ThrowIfNull(context, nameof(context));
        ArgumentNullException.ThrowIfNull(operation, nameof(operation));

        var apiDescription = context.ApiDescription;

        operation.Deprecated |= apiDescription.IsDeprecated();

        // REF: https://github.com/domaindrivendev/Swashbuckle.AspNetCore/issues/1752#issue-663991077
        foreach (var responseType in context.ApiDescription.SupportedResponseTypes)
        {
            // REF: https://github.com/domaindrivendev/Swashbuckle.AspNetCore/blob/b7cf75e7905050305b115dd96640ddd6e74c7ac9/src/Swashbuckle.AspNetCore.SwaggerGen/SwaggerGenerator/SwaggerGenerator.cs#L383-L387
            var responseKey = responseType.IsDefaultResponse ? "default" : responseType.StatusCode.ToString();
            var response = operation.Responses[responseKey];

            foreach (var contentType in response.Content.Keys)
            {
                if (!responseType.ApiResponseFormats.Any(x => x.MediaType == contentType))
                {
                    response.Content.Remove(contentType);
                }
            }
        }

        if (operation.Parameters == null)
        {
            return;
        }

        // REF: https://github.com/domaindrivendev/Swashbuckle.AspNetCore/issues/412
        // REF: https://github.com/domaindrivendev/Swashbuckle.AspNetCore/pull/413
        foreach (var parameter in operation.Parameters)
        {
            var description = apiDescription.ParameterDescriptions.First(p => p.Name == parameter.Name);

            parameter.Description ??= description.ModelMetadata?.Description;

            if (parameter.Schema.Default == null &&
                 description.DefaultValue != null &&
                 description.DefaultValue is not DBNull &&
                 description.ModelMetadata is ModelMetadata modelMetadata)
            {
                // REF: https://github.com/Microsoft/aspnet-api-versioning/issues/429#issuecomment-605402330
                var json = JsonSerializer.Serialize(
                    value: description.DefaultValue,
                    inputType: modelMetadata.ModelType,
                    options: new()
                    {
                        TypeInfoResolver = AppJsonSerializerContext.Default
                    });
                parameter.Schema.Default = OpenApiAnyFactory.CreateFromJson(json);
            }

            parameter.Required |= description.IsRequired;
        }
    }
}
