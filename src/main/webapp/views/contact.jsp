<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Château Fido</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/assets/css/styles.css">
</head>
<body>
    <jsp:include page="includes/headerHome.jsp" />
    
    <div class="site-container">
        <!-- Hero Section -->
        <div class="hero card">
            <div class="logo-emoji">📞</div>
            <h2>Contact Us</h2>
            <p class="muted">We'd love to hear from you! Get in touch with our team.</p>
        </div>

        <!-- Success Message -->
        <c:if test="${not empty successMessage}">
            <div class="card" style="margin-top: 28px; padding: 20px; background: #d4edda; border: 1px solid #c3e6cb; color: #155724; text-align: center;">
                <strong>✓ ${successMessage}</strong>
            </div>
        </c:if>

        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(320px, 1fr)); gap: 28px; margin-top: 28px;">
            
            <!-- Contact Information -->
            <div class="card" style="padding: 28px;">
                <h2 style="color: var(--accent); margin-bottom: 24px;">Get In Touch</h2>
                
                <div style="margin-bottom: 24px;">
                    <div style="display: flex; align-items: flex-start; gap: 12px; margin-bottom: 20px;">
                        <div style="font-size: 28px; color: var(--accent);">📍</div>
                        <div>
                            <h4 style="color: var(--accent); margin-bottom: 4px;">Address</h4>
                            <p style="color: var(--muted); line-height: 1.6;">
                                Universiti Teknologi MARA<br>
                                Shah Alam Campus<br>
                                40450 Shah Alam, Selangor<br>
                                Malaysia
                            </p>
                        </div>
                    </div>
                    
                    <div style="display: flex; align-items: flex-start; gap: 12px; margin-bottom: 20px;">
                        <div style="font-size: 28px; color: var(--accent);">📧</div>
                        <div>
                            <h4 style="color: var(--accent); margin-bottom: 4px;">Email</h4>
                            <p style="color: var(--muted);">
                                <a href="mailto:info@chateaufido.com" style="color: var(--accent); text-decoration: none;">
                                    info@chateaufido.com
                                </a><br>
                                <a href="mailto:support@chateaufido.com" style="color: var(--accent); text-decoration: none;">
                                    support@chateaufido.com
                                </a>
                            </p>
                        </div>
                    </div>
                    
                    <div style="display: flex; align-items: flex-start; gap: 12px; margin-bottom: 20px;">
                        <div style="font-size: 28px; color: var(--accent);">📱</div>
                        <div>
                            <h4 style="color: var(--accent); margin-bottom: 4px;">Phone</h4>
                            <p style="color: var(--muted);">
                                +60 3-5544 2000 (Main Line)<br>
                                +60 12-345 6789 (Emergency)
                            </p>
                        </div>
                    </div>
                    
                    <div style="display: flex; align-items: flex-start; gap: 12px;">
                        <div style="font-size: 28px; color: var(--accent);">🕐</div>
                        <div>
                            <h4 style="color: var(--accent); margin-bottom: 4px;">Business Hours</h4>
                            <p style="color: var(--muted); line-height: 1.8;">
                                Monday - Friday: 8:00 AM - 8:00 PM<br>
                                Saturday: 9:00 AM - 6:00 PM<br>
                                Sunday: 10:00 AM - 4:00 PM<br>
                                <em style="font-size: 0.9em;">24/7 Emergency Care Available</em>
                            </p>
                        </div>
                    </div>
                </div>
                
                <!-- Social Media -->
                <div style="margin-top: 32px; padding-top: 24px; border-top: 1px solid #f0e6e0;">
                    <h4 style="color: var(--accent); margin-bottom: 12px;">Follow Us</h4>
                    <div style="display: flex; gap: 16px; font-size: 32px;">
                        <a href="#" style="text-decoration: none;">📘</a>
                        <a href="#" style="text-decoration: none;">📷</a>
                        <a href="#" style="text-decoration: none;">🐦</a>
                        <a href="#" style="text-decoration: none;">💼</a>
                    </div>
                </div>
            </div>

            <!-- Contact Form -->
            <div class="card" style="padding: 28px;">
                <h2 style="color: var(--accent); margin-bottom: 24px;">Send Us a Message</h2>
                
                <form action="${pageContext.request.contextPath}/contact" method="post">
                    <div class="form-group">
                        <label for="name">Your Name *</label>
                        <input type="text" id="name" name="name" required 
                               placeholder="Enter your full name">
                    </div>
                    
                    <div class="form-group">
                        <label for="email">Email Address *</label>
                        <input type="email" id="email" name="email" required 
                               placeholder="your.email@example.com">
                    </div>
                    
                    <div class="form-group">
                        <label for="subject">Subject *</label>
                        <select id="subject" name="subject" required>
                            <option value="">Select a topic...</option>
                            <option value="booking">Booking Inquiry</option>
                            <option value="services">Services Information</option>
                            <option value="pricing">Pricing Questions</option>
                            <option value="special_needs">Special Care Requirements</option>
                            <option value="feedback">Feedback</option>
                            <option value="complaint">Complaint</option>
                            <option value="other">Other</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="message">Message *</label>
                        <textarea id="message" name="message" rows="6" required 
                                  placeholder="Tell us how we can help you..."
                                  style="resize: vertical; font-family: inherit;"></textarea>
                    </div>
                    
                    <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 8px;">
                        Send Message
                    </button>
                </form>
                
                <p class="muted small" style="margin-top: 16px; text-align: center;">
                    We typically respond within 24 hours during business days.
                </p>
            </div>
        </div>

        <!-- FAQ Section -->
        <div class="card" style="margin-top: 40px; padding: 32px;">
            <h2 style="color: var(--accent); margin-bottom: 24px; text-align: center;">
                Frequently Asked Questions
            </h2>
            
            <div style="max-width: 800px; margin: 0 auto;">
                <div style="margin-bottom: 24px; padding-bottom: 24px; border-bottom: 1px solid #f0e6e0;">
                    <h4 style="color: var(--accent); margin-bottom: 8px;">
                        What vaccination documents do I need to provide?
                    </h4>
                    <p style="color: var(--muted); line-height: 1.6;">
                        We require up-to-date vaccination records including rabies, DHPP (distemper, hepatitis, 
                        parvovirus, parainfluenza), and Bordetella. Documents must be uploaded during the booking 
                        process and will be verified by our staff before confirmation.
                    </p>
                </div>
                
                <div style="margin-bottom: 24px; padding-bottom: 24px; border-bottom: 1px solid #f0e6e0;">
                    <h4 style="color: var(--accent); margin-bottom: 8px;">
                        Can I bring my dog's own food and toys?
                    </h4>
                    <p style="color: var(--muted); line-height: 1.6;">
                        Absolutely! We encourage bringing your dog's regular food to maintain their diet consistency. 
                        You can also bring favorite toys, blankets, or other comfort items. All guest belongings 
                        are tracked in our system and returned upon checkout.
                    </p>
                </div>
                
                <div style="margin-bottom: 24px; padding-bottom: 24px; border-bottom: 1px solid #f0e6e0;">
                    <h4 style="color: var(--accent); margin-bottom: 8px;">
                        What is your cancellation policy?
                    </h4>
                    <p style="color: var(--muted); line-height: 1.6;">
                        Cancellations made 48 hours or more before check-in receive a full refund. 
                        Cancellations within 48 hours are subject to a 50% fee. Emergency situations 
                        are reviewed on a case-by-case basis.
                    </p>
                </div>
                
                <div style="margin-bottom: 24px;">
                    <h4 style="color: var(--accent); margin-bottom: 8px;">
                        Do you handle dogs with special medical needs?
                    </h4>
                    <p style="color: var(--muted); line-height: 1.6;">
                        Yes, we can accommodate dogs with special medical requirements. Please contact us 
                        directly to discuss your dog's specific needs, and we'll ensure our staff is 
                        properly prepared to provide appropriate care.
                    </p>
                </div>
            </div>
            
            <div style="text-align: center; margin-top: 32px;">
                <p style="color: var(--muted); margin-bottom: 16px;">
                    Still have questions?
                </p>
                <a href="#" onclick="document.getElementById('name').focus(); return false;" 
                   class="btn btn-secondary">
                    Send Us a Message
                </a>
            </div>
        </div>
    </div>

    <jsp:include page="includes/footer.jsp" />
</body>
</html>