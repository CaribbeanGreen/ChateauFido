<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Château Fido</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/assets/css/styles.css">
</head>
<body>
    <jsp:include page="includes/headerHome.jsp" />
    
    <div class="site-container">
        <!-- Hero Section -->
        <div class="hero card">
            <div class="logo-emoji">🏰</div>
            <h2>About Château Fido</h2>
            <p class="muted">Premium Dog Boarding & Care Since 2025</p>
        </div>

        <!-- Mission Section -->
        <div class="card" style="margin-top: 28px;">
            <h2 style="color: var(--accent); margin-bottom: 16px; text-align: center;">Our Mission</h2>
            <p style="text-align: center; color: var(--muted); max-width: 800px; margin: 0 auto; line-height: 1.8;">
                At Château Fido, we provide safe, comfortable, and luxurious accommodation for your beloved pets. 
                Our mission is to offer peace of mind to pet owners through professional care, state-of-the-art facilities, 
                and a commitment to the health and happiness of every furry guest.
            </p>
        </div>

        <!-- Features Grid -->
        <div style="margin-top: 28px;" class="grid">
            <div class="feature card text-center">
                <div class="icon">🏠</div>
                <h3>Luxury Accommodations</h3>
                <p class="muted">
                    Spacious, climate-controlled rooms designed for maximum comfort. Each kennel is equipped 
                    with cozy bedding and plenty of space for your dog to relax.
                </p>
            </div>
            
            <div class="feature card text-center">
                <div class="icon">💝</div>
                <h3>Expert Care Team</h3>
                <p class="muted">
                    Our professional staff are trained in pet care, behavior management, and emergency response. 
                    Your dog's safety and wellbeing are our top priorities.
                </p>
            </div>
            
            <div class="feature card text-center">
                <div class="icon">🩺</div>
                <h3>Health-First Policy</h3>
                <p class="muted">
                    We require up-to-date vaccination records for all guests. Our strict health verification 
                    process ensures a safe environment for every pet.
                </p>
            </div>
            
            <div class="feature card text-center">
                <div class="icon">📱</div>
                <h3>Easy Online Booking</h3>
                <p class="muted">
                    Reserve your dog's stay with our user-friendly online system. Real-time availability, 
                    instant confirmations, and secure payment processing.
                </p>
            </div>
            
            <div class="feature card text-center">
                <div class="icon">🎾</div>
                <h3>Play & Exercise</h3>
                <p class="muted">
                    Daily activities and supervised playtime keep your dog active and engaged. 
                    We tailor activities to your dog's age, breed, and energy level.
                </p>
            </div>
            
            <div class="feature card text-center">
                <div class="icon">🍖</div>
                <h3>Specialized Diets</h3>
                <p class="muted">
                    We accommodate special dietary requirements and can use your dog's preferred food. 
                    All meals are served on a consistent schedule.
                </p>
            </div>
        </div>

        <!-- Why Choose Us Section -->
        <div class="card" style="margin-top: 40px; padding: 32px;">
            <h2 style="color: var(--accent); margin-bottom: 24px; text-align: center;">Why Choose Château Fido?</h2>
            
            <div style="max-width: 800px; margin: 0 auto;">
                <div style="margin-bottom: 20px;">
                    <h3 style="color: var(--accent); margin-bottom: 8px;">✓ Transparent Operations</h3>
                    <p style="color: var(--muted); line-height: 1.6;">
                        Our integrated management system tracks every aspect of your dog's stay, from check-in to check-out. 
                        You'll always know your pet is in good hands.
                    </p>
                </div>
                
                <div style="margin-bottom: 20px;">
                    <h3 style="color: var(--accent); margin-bottom: 8px;">✓ Inventory Excellence</h3>
                    <p style="color: var(--muted); line-height: 1.6;">
                        We maintain optimal stock levels of food, treats, toys, and supplies. Our real-time inventory 
                        system ensures we never run out of essentials.
                    </p>
                </div>
                
                <div style="margin-bottom: 20px;">
                    <h3 style="color: var(--accent); margin-bottom: 8px;">✓ Personal Belongings Tracking</h3>
                    <p style="color: var(--muted); line-height: 1.6;">
                        Bring your dog's favorite toys, blanket, or special food. We log all guest belongings 
                        and ensure everything is returned to you upon checkout.
                    </p>
                </div>
                
                <div style="margin-bottom: 20px;">
                    <h3 style="color: var(--accent); margin-bottom: 8px;">✓ 24/7 Supervision</h3>
                    <p style="color: var(--muted); line-height: 1.6;">
                        Our facility is staffed around the clock to monitor your dog's health, comfort, and safety. 
                        Emergency veterinary services are available if needed.
                    </p>
                </div>
            </div>
        </div>

        <!-- Team Section -->
        <div class="card" style="margin-top: 40px; padding: 32px; text-align: center;">
            <h2 style="color: var(--accent); margin-bottom: 16px;">Meet Our Team</h2>
            <p style="color: var(--muted); max-width: 700px; margin: 0 auto 24px; line-height: 1.8;">
                Château Fido is managed by a dedicated team of computer science students from Universiti 
                Teknologi MARA, combining technical expertise with a passion for animal care.
            </p>
            
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin-top: 28px;">
                <div>
                    <div style="font-size: 48px; margin-bottom: 8px;">👨‍💼</div>
                    <h4 style="color: var(--accent); margin-bottom: 4px;">Ahmad Amadi</h4>
                    <p class="muted small">System Administrator</p>
                </div>
                <div>
                    <div style="font-size: 48px; margin-bottom: 8px;">👨‍💻</div>
                    <h4 style="color: var(--accent); margin-bottom: 4px;">Muhammad Aiman</h4>
                    <p class="muted small">Lead Developer</p>
                </div>
                <div>
                    <div style="font-size: 48px; margin-bottom: 8px;">👨‍🔧</div>
                    <h4 style="color: var(--accent); margin-bottom: 4px;">Muhamad Fakrol Razi</h4>
                    <p class="muted small">Database Specialist</p>
                </div>
                <div>
                    <div style="font-size: 48px; margin-bottom: 8px;">👩‍💼</div>
                    <h4 style="color: var(--accent); margin-bottom: 4px;">Nur Hidayah</h4>
                    <p class="muted small">UX/UI Designer</p>
                </div>
            </div>
        </div>

        <!-- CTA Section -->
        <div class="card" style="margin-top: 40px; padding: 40px; text-align: center; background: linear-gradient(180deg, var(--glass), rgba(255,255,255,0.4));">
            <h2 style="color: var(--accent); margin-bottom: 16px;">Ready to Book Your Dog's Stay?</h2>
            <p style="color: var(--muted); margin-bottom: 24px;">
                Join hundreds of satisfied pet owners who trust Château Fido
            </p>
            <div>
                <a href="${pageContext.request.contextPath}/register" class="btn btn-primary" style="margin-right: 12px;">
                    Sign Up Now
                </a>
                <a href="${pageContext.request.contextPath}/contact" class="btn btn-secondary">
                    Contact Us
                </a>
            </div>
        </div>
    </div>

    <jsp:include page="includes/footer.jsp" />
</body>
</html>