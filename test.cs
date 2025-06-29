namespace TaskLib.Tests
{
    using System;

    using FluentAssertions;
    using NUnit.Framework;

    [TestFixture]
    public class StringHelpersTests
    {
        [Test]
        [ExpectedException(typeof(ArgumentException))]
        public void When_WordToFindIsNotInTheInput_Then_ArgumentExceptionIsThrown()
        {
            // Arrange
            var tested = new StringHelpers();

            // Act
            var word = tested.GetWordFromText("two words", 3);
        }

        [Test]
        public void When_InputTextContainsFewWords_Then_ProperOneIsReturned()
        {
            // Arrange
            var tested = new StringHelpers();

            // Act
            var word = tested.GetWordFromText("few short fancy words", 3);

            // Assert
            word.Should().Be("fancy");
        }

        [Test]
        public void When_InputTextIsSymmetrical_Then_ItIsReturned()
        {
            // Arrange
            var tested = new StringHelpers();

            // Act
            var reversed = tested.Reverse("evil live");

            // Assert
            reversed.Should().Be("evil live");
        }

        [Test]
        public void When_InputTextIsPassed_Then_ItIsReversed()
        {
            // Arrange
            var tested = new StringHelpers();

            // Act
            var reversed = tested.Reverse("abcd efgh");

            // Assert
            reversed.Should().Be("hgfe dcba");
        }
    }
}
