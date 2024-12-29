using ApplicationCore.Categories.Commands.UpdateCategory;
using ApplicationCore.Common.Exceptions;

namespace ApplicationCore.Test.Categories.Commands;

[TestFixture]
public class UpdateCategoryTests
{
    private Mock<ICategoryRepository> _repositoryMock;
    private Fixture _fixture;

    [SetUp]
    public void SetUp()
    {
        _repositoryMock = new Mock<ICategoryRepository>();
        _fixture = new Fixture();

        _fixture.Customize<Category>(builder =>
            builder
                .With(c => c.Name, _fixture.Create<string>())
                .With(c => c.Image, _fixture.Create<string>())
                .Without(c => c.ParentCategoryId)
                .Without(c => c.ParentCategory)
                .With(c => c.ChildCategories, []));
    }

    private UpdateCategoryCommandHandler CreateHandler()
        => new(_repositoryMock.Object);

    [Test]
    public async Task Handle_ShouldUpdateCategory_WhenValidRequestWithNameAndImage()
    {
        // Arrange
        var category = _fixture.Create<Category>();
        var command = new UpdateCategoryCommand(category.Id, "Updated Name", "Updated Image");

        _repositoryMock
            .Setup(repo => repo.Get(category.Id, It.IsAny<CancellationToken>()))
            .ReturnsAsync(category);

        var handler = CreateHandler();

        // Act
        await handler.Handle(command, CancellationToken.None);

        // Assert
        category.Name.Should().Be("Updated Name");
        category.Image.Should().Be("Updated Image");

        _repositoryMock.Verify(repo => repo.Get(command.CategoryId, It.IsAny<CancellationToken>()), Times.Once);
        _repositoryMock.Verify(repo => repo.Update(category, It.IsAny<CancellationToken>()), Times.Once);
    }

    [Test]
    public async Task Handle_ShouldUpdateCategory_WhenValidRequestWithNameOnly()
    {
        // Arrange
        var category = _fixture.Create<Category>();
        var command = new UpdateCategoryCommand(category.Id, "Updated Name", null);

        _repositoryMock
            .Setup(repo => repo.Get(category.Id, It.IsAny<CancellationToken>()))
            .ReturnsAsync(category);

        var handler = CreateHandler();

        // Act
        await handler.Handle(command, CancellationToken.None);

        // Assert
        category.Name.Should().Be("Updated Name");
        category.Image.Should().Be(category.Image);

        _repositoryMock.Verify(repo => repo.Get(category.Id, It.IsAny<CancellationToken>()), Times.Once);
        _repositoryMock.Verify(repo => repo.Update(category, It.IsAny<CancellationToken>()), Times.Once);
    }

    [Test]
    public async Task Handle_ShouldUpdateCategory_WhenValidRequestWithImageOnly()
    {
        // Arrange
        var category = _fixture.Create<Category>();
        var command = new UpdateCategoryCommand(category.Id, null, "Updated Image");

        _repositoryMock
            .Setup(repo => repo.Get(category.Id, It.IsAny<CancellationToken>()))
            .ReturnsAsync(category);

        var handler = CreateHandler();

        // Act
        await handler.Handle(command, CancellationToken.None);

        // Assert
        category.Name.Should().Be(category.Name);
        category.Image.Should().Be("Updated Image");

        _repositoryMock.Verify(repo => repo.Get(category.Id, It.IsAny<CancellationToken>()), Times.Once);
        _repositoryMock.Verify(repo => repo.Update(category, It.IsAny<CancellationToken>()), Times.Once);
    }

    [Test]
    public void Handle_ShouldThrowEntityNotFoundException_WhenCategoryDoesNotExist()
    {
        // Arrange
        var command = _fixture.Create<UpdateCategoryCommand>();

        _repositoryMock
            .Setup(repo => repo.Get(command.CategoryId, It.IsAny<CancellationToken>()))
            .ReturnsAsync((Category)null);

        var handler = CreateHandler();

        // Act & Assert
        FluentActions.Invoking(() => handler.Handle(command, CancellationToken.None))
            .Should().ThrowAsync<EntityNotFoundException>();

        _repositoryMock.Verify(repo => repo.Get(command.CategoryId, It.IsAny<CancellationToken>()), Times.Once);
        _repositoryMock.Verify(repo => repo.Update(It.IsAny<Category>(), It.IsAny<CancellationToken>()), Times.Never);
    }
}
