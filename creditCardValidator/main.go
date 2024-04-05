package main

import (
	"fmt"
	"regexp"
	"strings"
)

// isValidCreditCard checks if the credit card number is valid according to the given criteria.
func isValidCreditCard(number string) bool {
	// Remove all hyphens for consistent processing
	cleanedNumber := strings.ReplaceAll(number, "-", "")

	// Check if the card starts with a 4, 5, or 6 and is exactly 16 digits long
	if match, _ := regexp.MatchString(`^[456]\d{15}$`, cleanedNumber); !match {
		return false
	}

	// Check for consecutive repeated digits (4 or more)
	for i := 0; i < len(cleanedNumber)-3; i++ {
		if cleanedNumber[i] == cleanedNumber[i+1] &&
			cleanedNumber[i+1] == cleanedNumber[i+2] &&
			cleanedNumber[i+2] == cleanedNumber[i+3] {
			return false
		}
	}

	// Check the formatting of the input number
	if len(number) != 16 {
		if match, _ := regexp.MatchString(`^(\d{4}-){3}\d{4}$`, number); !match {
			return false
		}
	}

	return true
}

func main() {
	cardNumbers := []string{
		"4253625879615786",      // Valid
		"4424424424442444",      // Valid
		"5122-2368-7954-3214",   // Valid
		"42536258796157867",     // Invalid: Too many digits
		"4424444424442444",      // Invalid: Consecutive repeated digits
		"5122-2368-7954 - 3214", // Invalid: Improper separators
		"44244x4424442444",      // Invalid: Non-numeric characters
		"0525362587961578",      // Invalid: Does not start with 4, 5, or 6
	}

	for _, number := range cardNumbers {
		if isValidCreditCard(number) {
			fmt.Printf("%s is a valid credit card number.\n", number)
		} else {
			fmt.Printf("%s is not a valid credit card number.\n", number)
		}
	}
}
